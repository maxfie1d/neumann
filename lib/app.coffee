{CompositeDisposable} = require 'atom'
RandomAlgorithm = require './algorithm/random-algorithm'
NeumannAlgorithm = require './algorithm/neumann-algorithm'

module.exports =
	# シングルトンです
	class App
		instance = null

		# 唯一のインスタンスを返します
		@instance: ->
			instance ?= new PrivateApp

		class PrivateApp
			algorithm: null						# 使用中のアルゴリズム
			neumannAlgorithm: null		# ノイマンアルゴリズムのインスタンス
			randomAlgorithm: null			# ランダムアルゴリズムのインスタンス

			constructor: ->
				@subscriptions = new CompositeDisposable

				@neumannAlgorithm = new NeumannAlgorithm()
				@randomAlgorithm = new RandomAlgorithm()

				algorithm = atom.config.get('neumann.algorithm')
				@updateAlgorithm(algorithm)

				# アルゴリズムが変更されたら使用するアルゴリズムを更新
				@subscriptions.add atom.config.observe 'neumann.algorithm', (newValue) => @updateAlgorithm(newValue)

				# ノイマンアルゴリズムで使用するルールの変更を監視
				@subscriptions.add atom.config.observe 'neumann.neumannAlgorithmSettings.isMidnightRuleEnabled', (newValue) => @neumannAlgorithm.rules['midnight'].isEnabled = newValue
				@subscriptions.add atom.config.observe 'neumann.neumannAlgorithmSettings.isUnreliableMembersRuleEnabled', (newValue) => @neumannAlgorithm.rules['unreliableMembers'].isEnabled = newValue
				@subscriptions.add atom.config.observe 'neumann.neumannAlgorithmSettings.isEditHistoryRuleEnabled', (newValue) => @neumannAlgorithm.rules['editHistory'].isEnabled = newValue
				@subscriptions.add atom.config.observe 'neumann.neumannAlgorithmSettings.isNotCommittedRuleEnabled', (newValue) => @neumannAlgorithm.rules['notCommitted'].isEnabled = newValue

			# 使用するアルゴリズムを更新します
			updateAlgorithm: (newAlgorithm) ->
				switch newAlgorithm
					when "Neumann Algorithm"
						@algorithm = @neumannAlgorithm
					when "Random Algorithm"
						@algorithm = @randomAlgorithm
