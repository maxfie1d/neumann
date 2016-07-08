{ScrollView} = require 'atom-space-pen-views'
d3 = require 'd3'
d3sc = require 'd3-scale-chromatic'
TextEditorHelper = require '../helpers/text-editor-helper'
FileHelper = require '../helpers/file-helper'
$ = require 'jquery'

module.exports =
	class SuspiciousGraphView extends ScrollView
		@content: ->
			@div class: 'suspicious-graph', =>
				@div outlet: 'container', =>
					@h1 'Suspicious Graph'

		constructor: ({@editorId})->
			super
			@editor = TextEditorHelper.getEditorForId(@editorId)

		# タブに表示されるタイトル
		getTitle: ->
			'suspicious-graph'

		# [必須]atom.workspace.paneForURIメソッドを使用するため
		getURI: ->
			"neumann://suspicious-graph/#{@editorId}"

		# DOMの表示が完了したら描画する
		attached: ->
			if @editor?
				FileHelper.getEvaluatedCodeLines(@editor.getPath())
				.then (codeLines) =>
					@renderSuspiciousGraph(codeLines)
					$(window).resize =>
						@update()

				.catch (e) =>
					console.log e
					# エラーの場合はビューを閉じる
					uri = @getURI()
					graphPane = atom.workspace.paneForURI(uri)
					graphPane.destroyItem(graphPane.itemForURI(uri))


		renderSuspiciousGraph: (codeLines) ->
			dataSet = codeLines

			# アニメーションの長さ
			duration = 1500
			# アニメーションのディレイ
			delay = 50
			# 棒の縦幅
			barHeight = 24
			# 棒の右端の縦棒のはみ出し部分
			barOverflow = 17
			# グラフの間隔
			padding = 8
			# ひとつのバーで使う領域
			bandwidth = barHeight + barOverflow + padding

			width = @width() - 20
			height = bandwidth * dataSet.length - padding

			# svg要素を追加
			@svg = d3.select(@container.get(0))
			.append("svg")
			.attr("width", width)
			.attr("height", height)

			@scaleX = d3.scaleLinear()
			.domain([0, d3.max(dataSet, (d) -> d.totalSuspicious())])
			.range([0, width])

			@scaleY = d3.scaleBand()
			.domain(d3.range(dataSet.length))
			.range([0, height])
			.paddingInner(padding / bandwidth)

			@scaleColor = d3.scaleSequential()
			.domain([0, d3.max(dataSet, (d) -> d.totalSuspicious())])
			.interpolator((t) ->
				return d3sc.interpolateGnBu(0.5 + t/2))

			@bars = @svg.selectAll(".bar")
			.data(dataSet)
			.enter()
			.append("g")
			.attr("class", "bar")
			.attr("transform", (d, i) => "translate(0, #{@scaleY(i)})")

			# 棒の背景を描画
			@bars
			.append("rect")
			.attr("class", "background")
			.attr("x", 0)
			.attr("width", width)
			.attr("height", barHeight)
			.attr("opacity", 0)
			.on("click", (d, i) => @jumpTo(d))
			.transition()
			.duration(duration / 2)
			.delay((d,i) -> i * delay)
			.attr("opacity", .05)

			# 棒を描画
			@bars
			.append("rect")
			.attr("class", "bar-rect")
			.attr("x", 0)
			.attr("width", 0)
			.attr("height", barHeight)
			.attr("fill", @scaleColor(@scaleColor.domain()[0]))
			.on("click", (d, i) => @jumpTo(d))
			.transition()
			.duration(duration)
			.delay((d,i) -> i * delay)
			.attr("width", (d) => @scaleX(d.totalSuspicious()))
			.attrTween("fill", (d) =>
				return (t) =>
					@scaleColor(d.totalSuspicious() * t)
					)

			# 棒の右端の縦棒を描画
			@bars
			.append("rect")
			.attr("class", "vertical")
			.attr("x", 0 - 3)
			.attr("width", 3)
			.attr("height", barHeight + barOverflow)
			.attr("fill", (d) => @scaleColor(d.totalSuspicious()))
			.transition()
			.duration(duration)
			.delay((d,i) -> i * delay)
			.attr("x", (d) => @scaleX(d.totalSuspicious()) - 3)
			.attrTween("fill", (d) =>
				return (t) =>
					@scaleColor(d.totalSuspicious() * t)
					)

			# コードのラベルを描画
			@bars
			.append("text")
			.attr("class", "code")
			.attr("x", 5)
			.attr("y", barHeight / 2)
			.attr("opacity", 0)
			.text((d) -> d.raw)
			.transition()
			.delay(duration / 10)
			.transition()
			.duration(duration / 2)
			.delay((d,i) -> i * delay)
			.attr("opacity", 1)

			# 疑わしさのラベルを描画
			@bars
			.append("text")
			.attr("class", "suspicious")
			.attr("x", 0 - 5)
			.attr("y", barHeight + barOverflow - 1)
			.text((d) -> d.totalSuspicious())
			.transition()
			.duration(duration)
			.delay((d,i) -> i * delay)
			.attr("x", @textSuspiciousAttrXCallback)
			.tween("text", (d) ->
				i = d3.interpolate(0, d.totalSuspicious())
				return (t) =>
					this.textContent = Math.round(i(t))
				)

		update: ->
			width = @width() - 20

			# svgのサイズを更新
			@svg
			.attr("width", width)

			# スケールを更新
			@scaleX.range [0, width]

			# 棒の背景を再描画
			@bars
			.selectAll("rect.background")
			.attr("width", width)

			# 棒を再描画
			@bars
			.selectAll("rect.bar-rect")
			.attr("width", (d) => @scaleX(d.totalSuspicious()))

			# 棒の右端の縦棒を再描画
			@bars
			.selectAll("rect.vertical")
			.attr("x", (d) => @scaleX(d.totalSuspicious()) - 3)

			# 疑わしさのラベルを再描画
			@bars
			.selectAll("text.suspicious")
			.attr("x", @textSuspiciousAttrXCallback)


		textSuspiciousAttrXCallback: (d) =>
			if @scaleX(d.totalSuspicious()) - 5 > 10
				@scaleX(d.totalSuspicious()) - 5
			else
				10

		jumpTo: (codeLine) ->
			uri = @getURI()
			pane = atom.workspace.paneForItem(@editor)
			if pane?
				# グラフに対応するTextEditorにフォーカスする
				pane.activate()
				pane.activateItem(@editor)

				# カーソル位置を移動
				@editor.setCursorBufferPosition([codeLine.line - 1, 0], autoscroll: true)
