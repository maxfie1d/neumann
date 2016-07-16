RuleBase = require './rule-base'
Rules = require './rules'
Levels = require '../levels'
EvaluationReason = require '../evaluation-reason'

module.exports =
	# 夜に書かれたコードはやばいルールです
	class MidnightRule extends RuleBase
		constructor: (@start, @end) ->

		evaluate: (codeLines) ->
			for codeLine in codeLines
				hours = codeLine.timestamp.getHours()
				# @startから@endまでに書かれたコードなら危険と判定する
				if hours >= @start || hours <= @end

					# MidnightRuleで危険と判定されたことを記録します
					codeLine.evaluations.push {
						rule: Rules.Midnight
						suspicious: 100
					}

		evaluationReason: (evaluation) ->
			reason = "#{@start}時から#{@end}時の間に書かれたコードです"
			return new EvaluationReason(Levels.warning, reason)
