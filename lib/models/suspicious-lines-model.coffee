{CompositeDisposable, Emitter} = require 'atom'
git = require '../git'
SuspiciousLinesView = require '../views/suspicious-lines-view'
CodeLine = require '../models/code-line'
App = require '../app'

module.exports =
	class SuspiciousLinesModel
		constructor: (@editor) ->
			@subscriptions = new CompositeDisposable
			# イベントの発火などに使用します
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
				codeLines = App.instance().algorithm.evaluate(codeLines)

				# 前のデコレーションとハンドラーを削除
				@destroy()

				# Viewにコードを渡す
				@view.create(codeLines)

				# イベントを発火
				@emitter.emit 'suspicious-lines-attach', editor: @editor, codeLines: codeLines, algorithm: App.instance().algorithm

				# Editorで何か編集されたら行の色付けを消す
				@handler = @editor.onDidStopChanging =>
					@destroy()
					@emitter.emit 'suspicious-lines-detach', @editor

			.catch (e) ->
				console.log e

		onSuspiciousLinesAttach: (callback) ->
			@emitter.on 'suspicious-lines-attach', callback

		onSuspiciousLinesDetach: (callback) ->
			@emitter.on 'suspicious-lines-detach', callback

		# 行の色付けを削除してハンドラーを始末する
		destroy: ->
			@view.destroy()
			@handler?.dispose()
