module.exports =
	# アルゴリズムの基底クラスです
	# 必ず以下のメソッドをオーバーライドしてください
	# evaluate(codeLines)
	# evaluationReason(codeLine)
	class AlgorithmBase
		evaluate: (codeLines) ->
			# 派生クラスでオーバーライドされていなければ例外を発生させる
			throw new Error("NotImplementedException")

		# コードの評価の理由を返します
		evaluationReason: (codeLine) ->
			throw new Error("NotImplementedException")
