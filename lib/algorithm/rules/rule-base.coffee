module.exports =
	# ルールの基底クラスです
	# 必ずevaluateメソッドをオーバーライドしてください
	#
	# ルール例:
	# やばい人ルール
	# 夜に書かれたコードはやばいルール
	class RuleBase
		constructor: ->

		evaluate: (codeLines) ->
			throw new Error("NotImplementedException")

		evaluationReason: (codeLine) ->
			throw new Error("NotImplementedException")
