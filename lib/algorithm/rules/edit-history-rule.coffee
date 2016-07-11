RuleBase = require './rule-base'
Rules = require './rules'

module.exports =
	# 最近に書かれたコードはやばいルールです
	class EditHistoryRule extends RuleBase
		constructor: (@priority=1) ->

		evaluate: (codeLines) ->

			# maxtime mintime を求める			@timestamp = new Date(collection[3])
			maxTime = 0	#NewestTime　最大値	X2
			todayTime = new Date
			minTime = todayTime.getTime()	#OldestTime 	最小値	X1
			console.log todayTime.getTime()
			for codeLine in codeLines
				if maxTime < codeLine.timestamp.getTime()
					maxTime = codeLine.timestamp.getTime()

				if minTime > codeLine.timestamp.getTime()
					minTime = codeLine.timestamp.getTime()

			range = maxTime - minTime	#変域	X2-X1
			#以上で準備完了。以下点数付け

			#変更履歴で点数付け
			for codeLine in codeLines
				percentage = (codeLine.timestamp.getTime() - minTime) / range		#比例で点数付け
				console.log percentage
				codeLine.evaluations.push {
					rule: Rules.Edithistory
					suspicious: 10 * @priority * percentage
					d: codeLine.timestamp
				}

		evaluationReason: (evaluation) ->
			year  = d.getFullYear()		 	#	年（西暦）
			month = d.getMonth()				#	月
			date  = d.getDate()					#	日
			hour  = d.getHours()				#	時
			min   = d.getMinutes()			#	分
			sec   = d.getSeconds()			#	秒
			ms    = d.getMilliseconds()	#	ミリ秒（1000分の1秒）

			str  = "#{year}年#{month}月#{date}日"
			str += " #{hour}時#{min}分#{sec}秒"

			reason = "#{str}に書かれたコードです"
			return new EvaluationReason(Levels.warning, reason)
