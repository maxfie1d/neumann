module.exports =
	class SuspiciousLinesView
		constructor: (@editor) ->
			@decorations = []

		create: (output)=>
			@createView(output)

		# コード中の怪しい行を色付けします
		createView: (codeLines) ->
			# 正規化のために疑わしさの最大値を求める
			maxSuspicious =	Math.max.apply(null, (x.totalSuspicious for x in codeLines))

			# ゼロ除算を防ぐために
			# すべてのコードが危険度0の場合はmaxSuspiciousを1にする
			maxSuspicious = 1 if maxSuspicious == 0

			for codeLine in codeLines
				# 色付けする位置
				position = [codeLine.line - 1, 0]
				# マーカーを作成
				marker = @editor.markBufferPosition(position)
				# 1から10の10段階に正規化？
				number = Math.round(1.0 * codeLine.totalSuspicious / maxSuspicious * 9) + 1

				# 行番号を色付けする
				decoration = @editor.decorateMarker(marker, {type: 'line-number', class: "suspicious-line-number-#{number}"})
				@decorations.push decoration

				# 行を色付けする
				decoration = @editor.decorateMarker(marker, {type: 'line', class: "suspicious-line-#{number}"})
				@decorations.push decoration

		# 行の色付けを削除します
		destroy: =>
			# デコレーションを削除
			decoration.getMarker().destroy() for decoration in @decorations
			# キャッシュを空に
			@decorations = []
