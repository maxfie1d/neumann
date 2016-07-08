AlgorithmBase = require './algorithm-base'
RandomRule = require './rules/random-rule'
Rules = require './rules/rules'

module.exports =
	# 疑わしさをランダムで与えるアルゴリズムです
	class RandomAlgorithm extends AlgorithmBase
		constructor: ->
			@rules = [
				new RandomRule(),
			]

		evaluate: (codeLines) ->
			for rule in @rules
				rule.evaluate(codeLines)

			return codeLines

		evaluationReason: (codeLine) ->
			reasons = []
			if codeLine?
				for evaluation in codeLine.evaluations
					switch evaluation.rule
						when Rules.Random
							rule = @rules[0]

					reasons.push rule.evaluationReason(evaluation)

			return reasons
