RuleBase = require './rule-base'

module.exports =
  # 夜に書かれたコードはやばいルールです
  class EditHistoryRule extends RuleBase
    constructor: (@priority=1) ->

    evaluate: (codeLine) ->
      hours = codeLine.timestamp.getHours()
      # maxtime mintime を求める      @timestamp = new Date(collection[3])
			maxtime = 0	#NewestTime-X　最大
			todaytime = new Date
			mintime = todaytime.getTime()	#OldestTime-X 	最小

			for codeline in codeLines
				if maxtime < codeline.timestamp.getTime()
					maxtime = codeline.timestamp.getTime()

				if mintime > codeline.timestamp.getTime()
					mintime = codeline.timestamp.getTime()

			scale = maxtime - mintime

      if hours >= @start || hours <= @end
        return 10 * @priority
      else
        return 0
