RuleBase = require './rule-base'

module.exports =
	# 最近に書かれたコードはやばいルールです
	class EditHistoryRule extends RuleBase
		constructor: (@priority=1) ->

		evaluate: (codeLine,codeLines) ->

			# maxtime mintime を求める			@timestamp = new Date(collection[3])
			maxTime = 0	#NewestTime　最大値	X2
			todayTime = new Date
			minTime = todayTime.getTime()	#OldestTime 	最小値	X1

			for codeLine in codeLines
				if maxTime < codeLine.timestamp.getTime()
					maxTime = codeLine.timestamp.getTime()

				if minTime > codeLine.timestamp.getTime()
					mintime = codeLine.timestamp.getTime()

			scale = maxTime - minTime	#変域	X2-X1

			parcentage = (codeLine.timestamp.getTime() - minTime) / scale		#今の所比例で点数付け	要変更?
			return 10 * @priority * parcentage
