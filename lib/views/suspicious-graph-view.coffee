{ScrollView} = require 'atom-space-pen-views'

module.exports =
  class SuspiciousGraphView extends ScrollView
    @content: ->
      @div class: 'suspicious-graph'

    constructor: ->
      super

    # タブに表示されるタイトル
    getTitle: ->
      'suspicious-graph'
