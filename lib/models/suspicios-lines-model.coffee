{CompositeDisposable, Emitter} = require 'atom'
git = require '../git'
SuspiciousLinesView = require '../views/suspicious-lines-view'
CodeLine = require '../models/code-line'
RandomAlgorithm = require '../algorithm/random-algorithm'
NeumannAlgorithm = require '../algorithm/neumann-algorithm'

module.exports =
	class SuspiciousLinesModel
		constructor: (@editor) ->
			@subscriptions = new CompositeDisposable
			@emitter = new Emitter

			# コマンドを登録
			@subscriptions.add atom.commands.add atom.views.getView(@editor), 'neumann:suspicious-lines': => @invoke()

			@view = new SuspiciousLinesView(@editor)

		invoke: =>
			git.blame()
			.then (output) =>
				array = output.split('\n')[...-1]
				codeLines = []
				for item in array
					codeLine = new CodeLine(item)
					codeLines.push(codeLine)

				# アルゴリズムにコードを渡して疑わしさを評価してもらう
				algorithm = atom.config.get('neumann.algorithm')
				switch algorithm
					when "Neumann Algorithm"
						codeLines = NeumannAlgorithm.evaluate(codeLines)
					when "Random Algorithm"
						codeLines = RandomAlgorithm.evaluate(codeLines)

				# 前のデコレーションとハンドラーを削除
				@destroy()

				# Viewにコードを渡す
				@view.create(codeLines)

				# イベントを発火
				@emitter.emit 'suspicious-lines-attach', @editor

				@handler = @editor.onDidStopChanging =>
					@destroy()

			.catch (e) ->
				console.log e

		onSuspiciousLinesAttach: (callback) ->
			@emitter.on 'suspicious-lines-attach', callback

		onSuspiciousLinesDetach: (callback) ->
			@emitter.on 'suspicious-lines-detach', callback

		destroy: ->
			@view.destroy()
			@handler?.dispose()
			@emitter.emit 'suspicious-lines-detach', @editor
