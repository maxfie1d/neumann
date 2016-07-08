RuleBase = require './rule-base'
RandomNumberGenerator = require '../models/random-number-generator'
Rules = require './rules'
Levels = require './levels'
EvaluationReason = require './evaluation-reason'

module.exports =
	class RandomRule extends RuleBase
		constructor: (@priority=1) ->

		evaluate: (codeLines) ->
			for codeLine in codeLines
				codeLine.evaluations.push {
						rule: Rules.Random
						suspicious: RandomNumberGenerator.generate()
					}

		evaluationReason: (evaluation) ->
			reason = "なんとなく危険なコードです"
			return new EvaluationReason(Levels.error, reason)
