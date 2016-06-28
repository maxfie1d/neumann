{CompositeDisposable} = require 'atom'
GitBlame = require './models/git-blame'
SuspiciousLinesModel = require './models/suspicios-lines-model'

module.exports = Neumann =
  # ここにパッケージの設定を書く
  config:
    # gitのパスの設定
    gitPath:
      type: 'string'
      default: 'git'
      description: 'git path'
    # 使用するアルゴリズムの設定
    algorithm:
      type: 'string'
      default: "Neumann Algorithm"
      description: "Select algorithm to use."
      enum: [
        "Neumann Algorithm",
        "Random Algorithm"
      ]
    # 信頼できないメンバーの設定
    unreliableMembers:
      type: 'array'
      default: []
      items:
        type: 'string'
      description: "Unrealible members (comma-separated string)"

  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'neumann:git-blame': -> GitBlame()

    # 各TextEditorに対してSuspiciousLineViewを作る
    atom.workspace.observeTextEditors (editor) ->
      new SuspiciousLinesModel(editor)

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->
