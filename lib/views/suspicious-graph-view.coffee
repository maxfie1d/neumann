{ScrollView} = require 'atom-space-pen-views'
d3 = require 'd3'
$ = require 'jQuery'
ActiveFile = require '../models/active-file'

module.exports =
	class SuspiciousGraphView extends ScrollView
		@content: ->
			@div class: 'suspicious-graph', =>
				@div outlet: 'container', =>
					@h1 'Graph'

		constructor: ({@editorId})->
			super


		# タブに表示されるタイトル
		getTitle: ->
			'suspicious-graph'

		# [必須]atom.workspace.paneForURIメソッドを使用するため
		getURI: ->
			"neumann://suspicious-graph/#{@editorId}"

		# DOMの表示が完了したら描画する
		attached: ->
			# @renderBarChart()
			# @renderPieChart()

			# TODO: editorIdからTextEditorを取得し，CodeLineを取得するようにする
			ActiveFile.getEvaluatedCodeLines().then (codeLines) =>
				@renderSuspiciousGraph(codeLines)


		renderSuspiciousGraph: (codeLines) ->
			dataSet = codeLines

			width = @width() - 20
			height = 30 * dataSet.length

			# svg要素を追加
			svg = d3.select(@container.get(0))
			.append("svg")
			.attr("width", width)
			.attr("height", height)

			scaleX = d3.scaleLinear()
			.domain([0, d3.max(dataSet, (d) -> d.suspicious)])
			.range([0, width])

			scaleY = d3.scaleBand()
			.domain(d3.range(dataSet.length))
			.range([0, height])
			.paddingInner(.3) # 棒グラフの間隔(bandに対する割合)

			bars = svg.selectAll(".bar")
			.data(dataSet)
			.enter()
			.append("g")
			.attr("class", "bar")
			.attr("transform", (d, i) -> "translate(0, #{scaleY(i)})")

			# 棒を描画
			bars
			.append("rect")
			.attr("x", 0)
			.attr("width", (d) -> scaleX(d.suspicious))
			.attr("height", scaleY.bandwidth())
			.attr("fill", "blue")

			# コードのラベルを描画
			bars
			.append("text")
			.attr("class", "code")
			.attr("y", scaleY.bandwidth() / 2)
			.attr("fill", "white")
			.text((d) -> d.raw)

			# 疑わしさのラベルを描画
			bars
			.append("text")
			.attr("class", "suspicious")
			.attr("x", (d) -> scaleX(d.suspicious) - 3)
			.attr("y", scaleY.bandwidth() / 2)
			.attr("fill", "white")
			.text((d) -> d.suspicious)


		# 棒グラフ
		renderBarChart: ->
			dataSet = [
				{name: "a", val1: 1000, val2: 500},
				{name: "a", val1: 2000, val2: 400},
				{name: "a", val1: 3000, val2: 300},
				{name: "a", val1: 4000, val2: 200},
				{name: "a", val1: 5000, val2: 100},
			];

			W = 300
			H = 200

			# svg要素を追加
			svg = d3.select(@container.get(0))
			.append("svg")
			.attr("width", W)
			.attr("height", H)

			# 正規化する関数
			scale = d3.scaleLinear()
			.domain([0, d3.max(dataSet, (d) -> d.val1)])
			.range([0, H])

			# 棒グラフを描画
			barChart = svg.selectAll("rect")
			.data(dataSet)
			.enter()
			.append("rect")
			.attr("x", 0)
			.attr("y", (d, i) -> i * 30)
			.attr("width", (d) -> scale(d.val1))
			.attr("height", 20)
			.attr("fill", "blue")

		# 円グラフ
		renderPieChart: ->
			width = @width()
			aspect = 1.0

			dataSet = [
				60,
				30,
				10
			]

			# svg要素を追加
			svg = d3.select(@container.get(0))
			.append("svg")
			.attr("viewBox", "0 0 #{width} #{width*aspect}")
			.attr("preserveAspectRatio", "xMidYMid meet")
			.attr("width", width)
			.attr("height", width * aspect)

			pie = d3.pie().value((d) -> d)
			arc = d3.arc().innerRadius(0).outerRadius(width/2)

			g = svg.selectAll(".arc")
			.data(pie(dataSet))
			.enter()
			.append("g")
			.attr("transform", "translate(#{width/2},#{width*aspect/2})")
			.attr("class", "arc")

			# 円弧の描画
			g.append("path")
			.attr("d", arc)
			.attr("stroke", "white")

			# ウィンドウサイズが変わったらsvgの大きさも変える
			$(window).resize =>
				width = @width()
				svg.attr("width", width)
				svg.attr("height", width * aspect)
