RuleBase = require './rule-base'

module.exports =
	# このメンバーはやばいルール
	class UnreliableMembersRule extends RuleBase
		constructor: (@priority=1) ->

		evaluate: (codeLines) ->
			for codeLine in codeLines
				# 信頼できないメンバーを取得
				unreliableMembers = atom.config.get('neumann.unreliableMembers')

				# 信頼できないメンバーのコードなら危険とする
				if unreliableMembers.indexOf(codeLine.author) >= 0
					codeLine.suspicious += 10 * @priority
