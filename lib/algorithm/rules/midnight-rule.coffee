RuleBase = require './rule-base'
Rules = require './rules'
Levels = require '../levels'
EvaluationReason = require '../evaluation-reason'

module.exports =
	# 夜に書かれたコードはやばいルールです
	class MidnightRule extends RuleBase
		constructor: (@start, @end) ->
			@RuleNum = Rules.Midnight

		evaluate: (codeLines) ->
			values = []
			for codeLine in codeLines
				hours = codeLine.timestamp.getHours()
				# (@start)時から(@end)時までに書かれたコードなら危険と判定する
				if @inRange hours
					# MidnightRuleで危険と判定されたことを記録します
					values.push {
						suspicious: 100
						rule: @RuleNum
					}
				else
					values.push {
						suspicious: 0
						rule: @RuleNum
					}
			return values

		evaluationReason: (evaluation) ->
			reason = "#{@start}時から#{@end}時の間に書かれたコードです"
			return new EvaluationReason(Levels.warning, reason)

		inRange: (hours) ->
			if @start <= @end
				return @start <= hours and hours <= @end
			else
				return @start <= hours or hours <= @end
