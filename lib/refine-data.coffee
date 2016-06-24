class Sort
	@sort_setting =
		class SortSettings
			# ソートの設定を格納するクラス
			# 優先度などを格納する
			standard = [
				{
					name: "author"
					priority: 10
				},{
					name: "time"
					priority: 3
				},{
					name: "numModified"
					priority: 5
				}
			]


	getDoubtfulList: (filename)->
		# ミスってそうなリストを配列で返す

