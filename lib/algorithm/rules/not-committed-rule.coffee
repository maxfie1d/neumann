RuleBase = require './rule-base'
Rules = require './rules'
Levels = require '../levels'
EvaluationReason = require '../evaluation-reason'

# 未コミットの場合のコミット者名
NOT_COMMITTED_YET = "Not Committed Yet"

module.exports =
	# 未コミットのコードはやばいルールです
	class NotCommittedRule extends RuleBase
		@RuleNum = Rules.NotCommittedRule
		constructor: ->

		evaluate: (codeLines) ->
			values = []
			for codeLine in codeLines
				# 未コミットならコードの著者がNot Committed Yetになる
				if codeLine.author is NOT_COMMITTED_YET
					values.push {
						suspicious: 100
						args: {
							rule: @RuleNum
						}
					}
				else
					values.push {
						suspicious: 0
						args: {
							rule: @RuleNum
						}
					}
			return values

		evaluationReason: (evaluation) ->
			reason = "未コミットのコードです"
			return new EvaluationReason(Levels.info, reason)
