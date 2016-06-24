{CompositeDisposable} = require 'atom'

module.exports =
  class SuspiciousLinesView
    constructor: (@editor) ->
      @decoration = null
      @subscriptions = new CompositeDisposable
      # コマンドを登録
      @subscriptions.add atom.commands.add atom.views.getView(@editor), 'neumann:change-line-background': => @change()

    change: =>
      @handler = @editor.onDidStopChanging(@destroyDecoration)

      selection = @editor.getSelectedScreenRange()

      marker = @editor.markBufferRange(selection)

      @decoration = @editor.decorateMarker(marker, {type: 'line', class: 'suspicious'})
    destroyDecoration: =>
      # デコレーションを削除
      @decoration.getMarker().destroy()
      # ハンドラーを削除
      @handler.dispose()
