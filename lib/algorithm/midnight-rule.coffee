RuleBase = require './rule-base'

module.exports =
	# 夜に書かれたコードはやばいルールです
	class MidnightRule extends RuleBase
		constructor: (@start, @end, @priority=1) ->

		evaluate: (codeLines) ->
			for codeLine in codeLines
				hours = codeLine.timestamp.getHours()
				# @startから@endまでに書かれたコードなら危険と判定する
				if hours >= @start || hours <= @end
					codeLine.suspicious += 10 * @priority
