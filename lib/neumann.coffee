{CompositeDisposable} = require 'atom'
GitBlame = require './models/git-blame'
SuspeciousLinesView = require './views/suspecious-lines-view'

module.exports = Neumann =
  # ここにパッケージの設定を書く
  config:
    gitPath:
      type: 'string'
      default: 'git'
      description: 'git path'

  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'neumann:git-blame': -> GitBlame()

    # 各TextEditorに対してSuspeciousLineViewを作る
    atom.workspace.observeTextEditors (editor) ->
      new SuspeciousLinesView(editor)

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->
