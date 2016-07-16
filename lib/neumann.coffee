{CompositeDisposable} = require 'atom'
SuspiciousLinesModel = require './models/suspicious-lines-model'
SuspiciousnessGraphModel = require './models/suspiciousness-graph-model'
SuspiciousnessGraphView = require './views/suspiciousness-graph-view'
SuspiciousnessReasonModel = require './models/suspiciousness-reason-model'

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

		suspiciousnessGraphModel = new SuspiciousnessGraphModel()
		@subscriptions.add atom.commands.add 'atom-workspace', 'neumann:suspiciousness-graph': -> suspiciousnessGraphModel.toggle()

		# 各TextEditorに対してSuspiciousLineViewを作る
		atom.workspace.observeTextEditors (editor) ->
			model = new SuspiciousLinesModel(editor)
			new SuspiciousnessReasonModel(model)

		# グラフのカスタムオープナーを定義
		atom.workspace.addOpener (uri) ->
			try
				url = require 'url'
				{protocol, host, path} = url.parse(uri)
			catch error
				return

			return unless protocol is 'neumann:'

			try
				path = decodeURI(path)
			catch error
				return

			return new SuspiciousnessGraphView(editorId: path.substring(1))


	deactivate: ->
		@subscriptions.dispose()

	serialize: ->
