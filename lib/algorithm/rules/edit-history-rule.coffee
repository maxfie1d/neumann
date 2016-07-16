RuleBase = require './rule-base'
Rules = require './rules'
Levels = require '../levels'
EvaluationReason = require '../evaluation-reason'

module.exports =
	# 最近に書かれたコードはやばいルールです
	class EditHistoryRule extends RuleBase
		constructor: (@priority=1) ->

		evaluate: (codeLines) ->

			# maxtime mintime を求める			@timestamp = new Date(collection[3])
			maxTime = 0	#NewestTime　最大値	X2
			todayTime = new Date
			minTime = todayTime.getTime()	#OldestTime 	最小値	X1

			for codeLine in codeLines
				if maxTime < codeLine.timestamp.getTime()
					maxTime = codeLine.timestamp.getTime()

				if minTime > codeLine.timestamp.getTime()
					minTime = codeLine.timestamp.getTime()

			range = maxTime - minTime	#変域	X2-X1
			#以上で準備完了。以下点数付け

			#変更履歴で点数付け
			for codeLine in codeLines
				if range != 0
					percentage = @evaluationValue(codeLine,maxTime,minTime,range)
				else
					percentage = 1.0

				codeLine.evaluations.push {
					rule: Rules.EditHistory
					suspicious: 10 * @priority * percentage
					d: codeLine.timestamp
				}


		evaluationReason: (evaluation) ->
			year  = evaluation.d.getFullYear()		 	#	年（西暦）
			month = evaluation.d.getMonth()+1				#	月
			date  = evaluation.d.getDate()					#	日
			hour  = evaluation.d.getHours()				#	時
			min   = evaluation.d.getMinutes()			#	分
			sec   = evaluation.d.getSeconds()			#	秒
			ms    = evaluation.d.getMilliseconds()	#	ミリ秒（1000分の1秒）

			str  = "#{year}年#{month}月#{date}日"
			str += " #{hour}時#{min}分#{sec}秒"

			reason = "#{str}に書かれたコードです"
			return new EvaluationReason(Levels.warning, reason)


		evaluationValue: (codeLine,maxTime,minTime,range) ->

			rangeDay = range / 1000 / 3600 / 24
			timeMilliSecond = maxTime - codeLine.timestamp.getTime()
			timeHour = timeMilliSecond / 1000 / 3600
			timeDay = timeHour / 24
			timeWeek = timeDay / 7
			timeMonth = timeDay / 30

			#開発期間の短いファイルに対しては時期に比例して配点する
			if rangeDay <= 180
				value = timeMilliSecond / range
				console.log value
				return value

			#開発期間が1年以上のものに対しては時期に応じて以下の配点を行う。
			#24時間以内であれば90点以上
			if timeHour <= 24
				value = (24 - timeHour) / 24 * 10 + 90

			#3日以内であれば80点以上
			else if timeDay <= 3
				value = (3 - timeDay) / 3 * 10 + 80

			#7日以内であれば60点以上
			else if timeDay <= 7
				value = (7 - timeDay) / 4 * 20 + 60

			#4週間以内であれば50点以上
			else if timeWeek <= 4
				value = (4 - timeWeek) / 4 * 10 + 50

			#約1年以内であれば30点以上
			else if timeMonth <= 12
				value = (12 - timeMonth) / 12 * 20 + 30

			else
				timeYear = timeMonth / 12
				minTimeYear = minTime / 1000 / 3600 / 24 / 7 / 30 / 12
				value = ((minTimeYear - timeYear) / (minTimeYear - 1)) * 30

			console.log value

			rerutn value / 100
