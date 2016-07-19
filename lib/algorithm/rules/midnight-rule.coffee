RuleBase = require './rule-base'
Rules = require './rules'
Levels = require '../levels'
EvaluationReason = require '../evaluation-reason'

module.exports =
	# 夜に書かれたコードはやばいルールです
	class MidnightRule extends RuleBase
		@RuleNum = Rules.Midnight
		constructor: (@start, @end) ->

		evaluate: (codeLines) ->
			values = []
			for codeLine in codeLines
				hours = codeLine.timestamp.getHours()
				# (@start)時から(@end)時までに書かれたコードなら危険と判定する
				if hours >= @start || hours <= @end

					# MidnightRuleで危険と判定されたことを記録します
					values.push {
						suspicious: 100
						args:{
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
			reason = "#{@start}時から#{@end}時の間に書かれたコードです"
			return new EvaluationReason(Levels.warning, reason)
