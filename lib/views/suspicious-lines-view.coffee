module.exports =
	class SuspiciousLinesView
		constructor: (@editor) ->
			@decorations = []

		create: (output)=>
			@createView(output)

		createView: (codeLines) ->
			# 正規化のために疑わしさの最大値を求める
			maxSuspicious =	Math.max.apply(null, (x.suspicious for x in codeLines))

			for codeLine in codeLines
				position = [codeLine.line - 1, 0]
				marker = @editor.markBufferPosition(position)
				# 1から10の10段階に正規化？
				number = Math.round(1.0 * codeLine.suspicious / maxSuspicious * 9) + 1
				decoration = @editor.decorateMarker(marker, {type: 'line-number', class: "suspicious-line-number-#{number}"})
				@decorations.push decoration
				decoration = @editor.decorateMarker(marker, {type: 'line', class: "suspicious-line-#{number}"})
				@decorations.push decoration

		destroy: =>
			# デコレーションを削除
			decoration.getMarker().destroy() for decoration in @decorations
			# キャッシュを空に
			@decorations = []
