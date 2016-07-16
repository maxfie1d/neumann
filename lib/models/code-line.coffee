module.exports =
	class CodeLine
		constructor: (line) ->
			# 正規表現でgit blameの出力を分割
			# git blameの出力例
			# d3d87346 (tarohi24		 2016-06-11 19:11:24 +0900	8) # 開発ルール
			collection = line.match(/([0-9a-f\^]{8}).+?\((.+?)\s+([0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2} [+-][0-9]{4})\s+([0-9]+)\) (.*)/)

			# コミットiD
			@commitId = collection[1]
			# 著者
			@author = collection[2]
			# タイムスタンプ
			@timestamp = new Date(collection[3]) # Dateとして格納
			# 行番号
			@line = Number(collection[4]) # 数値として格納
			# コード部分
			@code = collection[5]

			# git blameの生の出力
			@raw	= line

			# 危険と判断したルールによる評価
			@evaluations = []
			# 算出した合計(計算はalgorithmで行うのでメソッドでなくフィールドとして定義)
			@totalSuspicious = 0

		toString: =>
			@raw
