RuleBase = require './rule-base'

module.exports =
	# 夜に書かれたコードはやばいルールです
	class MidnightRule extends RuleBase
		constructor: (@start, @end, @priority=1) ->

		evaluate: (codeLine,codeLines) ->
			hours = codeLine.timestamp.getHours()
			# @startから@endまでに書かれたコードなら危険と判定する
			if hours >= @start || hours <= @end
				return 10 * @priority
			else
				return 0
