{CompositeDisposable} = require 'atom'
RandomNumberGenerator = require '../models/random-number-generator'

module.exports =
  class SuspiciousLinesView
    constructor: (@editor) ->
      @decorations = []
      @subscriptions = new CompositeDisposable
      # コマンドを登録
      @subscriptions.add atom.commands.add atom.views.getView(@editor), 'neumann:change-line-background': => @change()

    change: =>
      @handler = @editor.onDidStopChanging(@destroyDecoration)

      lineCount = @editor.getLineCount()
      for i in [0 .. lineCount-1]
        position = [i, 0]
        marker = @editor.markBufferPosition(position)
        number = RandomNumberGenerator.generate()
        decoration = @editor.decorateMarker(marker, {type: 'line-number', class: "suspicious-line-number-#{number}"})
        @decorations.push decoration
        
    destroyDecoration: =>
      # デコレーションを削除
      decoration.getMarker().destroy() for decoration in @decorations
      # キャッシュを空に
      @decorations = []
      # ハンドラーを削除
      @handler.dispose()
