AlgorithmBase = require './algorithm-base'
MidnightRule = require './midnight-rule'
UnreliableMembersRule = require './unreliable-members-rule'
EditHistoryRule = require './edit-history-rule'
NotCommittedRule = require './not-committed-rule'
Rules = require '../algorithm/rules'

module.exports =
	class NeumannAlgorithm extends AlgorithmBase
		constructor: ->
			@rules = [
				new MidnightRule(16, 3, 10), # 16時～3時に書かれたコードは危険とする
				new UnreliableMembersRule(10),
				new NotCommittedRule(),
			]

			# 評価対象を絞り込む場合はその初日をインスタンスvalidDateに入れてください
			# 例) validDate = new Date("2016-07-01")
			@validDate = null

		evaluate: (codeLines) =>
			# 評価対象の絞り込み
			if @validDate?
				codeLines = codeLines.filter((codeLine) ->
					not codeLine.timestamp < @validDate
					)

			for rule in @rules
				rule.evaluate(codeLines)

			return codeLines

		# 評価の理由を取得します
		evaluationReason: (codeLine) ->
			reasons = []
			if codeLine?
				for evaluation in codeLine.evaluations
					switch evaluation.rule
						when Rules.Midnight
							rule = @rules[0]
						when Rules.Unreliable
							rule = @rules[1]
						when Rules.EditHistory
							console.error 'error'
						when Rules.NotCommittedRule
							rule = @rules[2]

					reasons.push rule.evaluationReason(evaluation)

			return reasons
