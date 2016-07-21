module.exports =
	# アルゴリズムの基底クラスです
	# 必ず以下のメソッドをオーバーライドしてください
	# evaluate(codeLines)
	# evaluationReason(codeLine)
	class AlgorithmBase

		# Regulate susArray's each value into the range [0,100]
		@regulateSuspiciousness: (susArray) ->
			min = Math.min.apply(null, susArray)
			susArray = (i - min for i in susArray)
			max = Math.max.apply(null, susArray)
			scale = if (max > 0) then (100 / max) else 0
			susArray = (i * scale for i in susArray)
			return susArray

		evaluate: (codeLines) ->
			# 派生クラスでオーバーライドされていなければ例外を発生させる
			throw new Error("NotImplementedException")

		# コードの評価の理由を返します
		evaluationReason: (codeLine) ->
			throw new Error("NotImplementedException")
