RuleBase = require './rule-base'
Rules = require './rules'
Levels = require '../levels'
EvaluationReason = require '../evaluation-reason'

module.exports =
	# このメンバーはやばいルール
	class UnreliableMembersRule extends RuleBase
		@RuleNum = Rules.Unreliable
		constructor: ->

		evaluate: (codeLines) ->
			values = []
			for codeLine in codeLines
				# 信頼できないメンバーを取得
				unreliableMembers = atom.config.get('neumann.neumannAlgorithmSettings.unreliableMembers')

				# 信頼できないメンバーのコードなら危険とする
				if (index = unreliableMembers.indexOf(codeLine.author)) >= 0
					values.push {
						suspicious: 100
						args: {
							rule: @RuleNum
							args: [unreliableMembers[index]]
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
			reason = "#{evaluation.args[0]}によって書かれたコードです"
			return new EvaluationReason(Levels.warning, reason)
