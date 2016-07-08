{CompositeDisposable} = require 'atom'
RandomAlgorithm = require './algorithm/random-algorithm'
NeumannAlgorithm = require './algorithm/neumann-algorithm'

module.exports =
	# シングルトンです
	class App
		instance = null

		@instance: ->
			instance ?= new PrivateApp

		class PrivateApp
			algorithm: null						# 使用中のアルゴリズム
			neumannAlgorithm: null		# ノイマンアルゴリズムのインスタンス
			randomAlgorithm: null			# ランダムアルゴリズムのインスタンス

			constructor: ->
				@subscriptions = new CompositeDisposable

				algorithm = atom.config.get('neumann.algorithm')
				@updateAlgorithm(algorithm)

				# アルゴリズムが変更されたら使用中のアルゴリズムを更新
				@subscriptions.add atom.config.observe 'neumann.algorithm', (newValue) => @updateAlgorithm(newValue)

			updateAlgorithm: (newAlgorithm) ->
				switch newAlgorithm
					when "Neumann Algorithm"
						@neumannAlgorithm ?= new NeumannAlgorithm()
						@algorithm = @neumannAlgorithm
					when "Random Algorithm"
						@randomAlgorithm ?= new RandomAlgorithm()
						@algorithm = @randomAlgorithm
