{ScrollView} = require 'atom-space-pen-views'

module.exports =
  class SuspiciousGraphView extends ScrollView
    @content: ->
      @div class: 'suspicious-graph'

    constructor: ({@editorId})->
      super

    # タブに表示されるタイトル
    getTitle: ->
      'suspicious-graph'

    # [必須]atom.workspace.paneForURIメソッドを使用するため
    getURI: ->
      "neumann://suspicious-graph/#{@editorId}"
