SuspiciousReasonView = require '../views/suspicious-reason-view'
{TextEditor} = require 'atom'
{CompositeDisposable} = require 'atom'

module.exports =
  class SuspiciousReasonModel
    constructor: (model) ->
      model.onSuspiciousLinesAttach ({editor: @editor, codeLines: @codeLines, algorithm: @algorithm}) => @create()
      model.onSuspiciousLinesDetach (editor) => @destroy(editor)

    create: ->
      # 前のハンドラーとViewを始末する
      @destroy()

      # CompositeDisposableは一回disposeメソッドを使うと，
      # それ以降disposeメソッドを呼んでも何もしなくなるみたいです
      @subscriptions = new CompositeDisposable

      # 現在のカーソルがある行の評価の理由を表示
      currentLine = @editor.getCursorBufferPosition().row + 1
      @updateReason(currentLine)

      # カーソルが動いたらカーソルが動いた先の行の評価の理由を表示するようにする
      @subscriptions.add @editor?.onDidChangeCursorPosition (args) =>
        newPositionLine = args.newBufferPosition.row + 1
        @updateReason(newPositionLine)

      @subscriptions.add atom.workspace.onDidChangeActivePaneItem (item) => @showOrHide item

    destroy: (editor) ->
      @subscriptions?.dispose()
      @view?.destroy()
      @view = null

    updateReason: (line) ->
      codeLine = x for x in @codeLines when x.line == line
      @view ?= new SuspiciousReasonView
      @view.update(@algorithm.evaluationReason(codeLine))

    showOrHide: (item) ->
      if item instanceof TextEditor
        if item.id == @editor.id
          @view.show()
        else
          @view.hide()
