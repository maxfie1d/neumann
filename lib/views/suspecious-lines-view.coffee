{CompositeDisposable} = require 'atom'

module.exports =
  class SuspeciousLinesView
    constructor: (@editor) ->
      @subscriptions = new CompositeDisposable
      # コマンドを登録
      @subscriptions.add atom.commands.add atom.views.getView(@editor), 'neumann:change-line-background': => @change()

    change: ->
      selection = @editor.getSelectedScreenRange()

      marker = @editor.markBufferRange(selection)

      decoration = @editor.decorateMarker(marker, {type: 'line', class: 'suspicious'})
