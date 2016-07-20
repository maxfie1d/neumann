RuleBase = require './rule-base'
RandomNumberGenerator = require '../../models/random-number-generator'
Rules = require './rules'
Levels = require '../levels'
EvaluationReason = require '../evaluation-reason'

module.exports =
	class RandomRule extends RuleBase
		constructor: ->
			@RuleNum = Rules.Random

		evaluate: (codeLines) ->
			values = []
			for codeLine in codeLines
				values.push {
					suspicious: RandomNumberGenerator.generate() # ランダムに危険度を与えます
					rule: @RuleNum
				}

			return values

		evaluationReason: (evaluation) ->
			reason = "なんとなく危険なコードです"
			return new EvaluationReason(Levels.error, reason)
