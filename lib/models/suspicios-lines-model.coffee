{CompositeDisposable} = require 'atom'
git = require '../git'
SuspiciousLinesView = require '../views/suspicious-lines-view'
CodeLine = require '../models/code-line'
RandomAlgorithm = require '../algorithm/random-algorithm'

module.exports =
  class SuspiciousLinesModel
    constructor: (@editor) ->
      @subscriptions = new CompositeDisposable

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
        codeLines = RandomAlgorithm.evaluate(codeLines)

        # Viewにコードを渡す
        @view.create(codeLines)
      .catch (e) ->
        console.log e
