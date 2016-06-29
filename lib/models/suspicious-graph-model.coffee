SuspiciousGraphView = require '../views/suspicious-graph-view'

module.exports =
  class suspiciousGraphModel
    constructor: ->

    invoke: ->
      # すでにグラフ画面がアクティブなら閉じる
      if atom.workspace.getActivePaneItem() instanceof SuspiciousGraphView
        atom.workspace.destroyActivePaneItem()
        return

      editor = atom.workspace.getActiveTextEditor()
      return unless editor?

      # TextEditorに対応するグラフがあれば閉じ，
      # なければグラフを表示
      if @graphForEditorExists(editor)
        @removeGraph(editor)
      else
        @addGraph(editor)

    graphUri: (editor) ->
      "neumann://suspicious-graph/#{editor.id}"

    graphForEditorExists: (editor) ->
      uri = @graphUri(editor)
      graphPane = atom.workspace.paneForURI(uri)
      return graphPane?

    addGraph: (editor) ->
      uri = @graphUri(editor)
      activePane = atom.workspace.getActivePane()
      # グラフを右側に開く
      atom.workspace.open(uri, {split: 'right', searchAllPanes: true}).done (view) ->
        # グラフを開いたらフォーカスを元に戻す
        if view instanceof SuspiciousGraphView
          activePane.activate()

    removeGraph: (editor) ->
      uri = @graphUri(editor)
      graphPane = atom.workspace.paneForURI(uri)
      graphPane.destroyItem(graphPane.itemForURI(uri))
