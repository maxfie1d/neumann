module.exports =
	# アルゴリズムの基底クラスです
	# 必ずevaluateメソッドをオーバーライドしてください
	class AlgorithmBase
		# 先頭に@をつけるとstaticメソッドになるそうです
		@evaluate: (codeLines) ->
			# 派生クラスでオーバーライドされていなければ例外を発生させる
			throw new Error("NotImplementedException")
