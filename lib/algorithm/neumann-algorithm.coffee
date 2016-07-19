AlgorithmBase = require './algorithm-base'
MidnightRule = require './rules/midnight-rule'
UnreliableMembersRule = require './rules/unreliable-members-rule'
EditHistoryRule = require './rules/edit-history-rule'
NotCommittedRule = require './rules/not-committed-rule'
Rules = require '../algorithm/rules/rules'

module.exports =
	class NeumannAlgorithm extends AlgorithmBase
		constructor: ->
			# ノイマンアルゴリズムはこれらのルールによって危険度を評価します
			@rules = {}

			@rules['midnight'] = {
				rule: new MidnightRule(16, 3)
				priority: 10
				isEnabled: atom.config.get 'neumann.neumannAlgorithmSettings.isMidnightRuleEnabled'
			}

			@rules['unreliableMembers']  = {
				rule: new UnreliableMembersRule()
				priority: 10
				isEnabled: atom.config.get 'neumann.neumannAlgorithmSettings.isUnreliableMembersRuleEnabled'
			}

			@rules['notCommitted'] = {
				rule: new NotCommittedRule()
				priority: 10
				isEnabled: atom.config.get 'neumann.neumannAlgorithmSettings.isNotCommittedRuleEnabled'
			}

			@rules['editHistory'] = {
				rule: new EditHistoryRule()
				priority: 10
				isEnabled: atom.config.get 'neumann.neumannAlgorithmSettings.isEditHistoryRuleEnabled'
			}

			# 評価対象を絞り込む場合はその初日をインスタンスvalidDateに入れてください
			# 例) validDate = new Date("2016-07-01")
			@validDate = null


		evaluate: (codeLines) =>
			# 評価対象の絞り込み
			if @validDate?
				codeLines = codeLines.filter((codeLine) ->
					not codeLine.timestamp < @validDate
				)

			# それぞれのルールでのsuspiciousを計算
			for key, rule of @rules
				if rule.isEnabled
					vals = rule['rule'].evaluate(codeLines)
					suspiciousnesses = AlgorithmBase.regulateSuspiciousness(val['suspicious'] for val in vals)
					if codeLines.length != vals.length
						throw new Error("illegal evaluate() in " + key + ". The method evaluate() should return as much elements as the codeLines.")
					for line,i in codeLines
						line.totalSuspicious += vals[i]['suspicious']*rule['priority']
						line.evaluations.push(vals[i]['args'])

			return codeLines

		# 評価の理由を取得します
		evaluationReason: (codeLine) ->
			reasons = []
			if codeLine?
				for evaluation in codeLine.evaluations
					switch evaluation.rule
						when Rules.Midnight
							rule = @rules['midnight']['rule']
						when Rules.Unreliable
							rule = @rules['unreliableMembers']['rule']
						when Rules.EditHistory
							rule = @rules['editHistory']['rule']
						when Rules.NotCommittedRule
							rule = @rules['notCommitted']['rule']

					reasons.push(rule.evaluationReason(evaluation))

			return reasons
