RuleBase = require './rule-base'
Rules = require './rules'
Levels = require '../levels'
EvaluationReason = require '../evaluation-reason'

NOT_COMMITTED_YET = "Not Committed Yet"

module.exports =
	# 未コミットのコードはやばいルールです
	class NotCommittedRule extends RuleBase
		constructor: (@priority=1) ->

		evaluate: (codeLines) ->
			for codeLine in codeLines
				# 未コミットならコードの著者がNot Committed Yetになる
				if codeLine.author is NOT_COMMITTED_YET
					codeLine.evaluations.push {
						rule: Rules.NotCommittedRule
						suspicious: 0 * @priority
					}

		evaluationReason: (evaluation) ->
			reason = "未コミットのコードです"
			return new EvaluationReason(Levels.info, reason)
