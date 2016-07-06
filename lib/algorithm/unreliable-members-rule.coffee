RuleBase = require './rule-base'
Rules = require './rules'

module.exports =
	# このメンバーはやばいルール
	class UnreliableMembersRule extends RuleBase
		constructor: (@priority=1) ->

		evaluate: (codeLines) ->
			for codeLine in codeLines
				# 信頼できないメンバーを取得
				unreliableMembers = atom.config.get('neumann.unreliableMembers')

				# 信頼できないメンバーのコードなら危険とする
				if (index = unreliableMembers.indexOf(codeLine.author)) >= 0
					codeLine.evaluations.push {
						rule: Rules.Unreliable
						args: [unreliableMembers[index]]
					}

					codeLine.suspicious += 10 * @priority
