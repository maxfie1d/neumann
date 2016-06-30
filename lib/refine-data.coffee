module.exports =
			class SortSettings
			# ソートの設定を格納するクラス
			# 優先度などを格納する

			# pri:priority（優先度）
			# sc:score（得点)
			constructor:(@auth_sc,@time_sc,@numMod_sc) ->

			#優先度はデフォルトでは均等
			@auth_pri = 1
			@time_pri = 1
			@numMod_pri = 1

			#重み付き平均により信頼性を計算（数値が高い程信頼出来ない）
			a_degree_of_insecurity: ->
          @sum_pri =  auth_pri + time_pri + numMod_pri
					sum = auth_sc * (auth_pri / sum_pri)
					      + time_sc * (time_pri / sum_pri)
								+ numMod_sc * (numMod_pri / sum_pri)
				 return sum

      #優先度の変更
			change_pri: (@auth_pri,@time_pri,@numMod_pri) ->
					  
