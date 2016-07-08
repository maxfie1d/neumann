RuleBase = require './rule-base'
Rules = require './rules'
Levels = require '../levels'
EvaluationReason = require '../evaluation-reason'

module.exports =
	# このメンバーはやばいルール
	class UnreliableMembersRule extends RuleBase
		constructor: ->

		evaluate: (codeLines) ->
			for codeLine in codeLines
				# 信頼できないメンバーを取得
				unreliableMembers = atom.config.get('neumann.unreliableMembers')

				# 信頼できないメンバーのコードなら危険とする
				if (index = unreliableMembers.indexOf(codeLine.author)) >= 0
					codeLine.evaluations.push {
						rule: Rules.Unreliable
						suspicious: 100
						args: [unreliableMembers[index]]
					}

		evaluationReason: (evaluation) ->
			reason = "#{evaluation.args[0]}によって書かれたコードです"
			return new EvaluationReason(Levels.warning, reason)
