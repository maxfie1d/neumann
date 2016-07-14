{CompositeDisposable} = require 'atom'
GitBlame = require './models/git-blame'
SuspiciousLinesModel = require './models/suspicios-lines-model'
SuspiciousGraphModel = require './models/suspicious-graph-model'
SuspiciousGraphView = require './views/suspicious-graph-view'
SuspiciousReasonModel = require './models/suspicious-reason-model'
OptionView = require './models/option-model'

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

		suspiciousGraphModel = new SuspiciousGraphModel()
		@subscriptions.add atom.commands.add 'atom-workspace', 'neumann:suspicious-graph': -> suspiciousGraphModel.toggle()

		#optionViewModel = new OptionView()
		#@subscriptions.add atom.commands.add 'atom-workspace', 'neumann:option': -> optionViewModel.toggle()

		# 各TextEditorに対してSuspiciousLineViewを作る
		atom.workspace.observeTextEditors (editor) ->
			model = new SuspiciousLinesModel(editor)
			new SuspiciousReasonModel(model)

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

			return new SuspiciousGraphView(editorId: path.substring(1))


	deactivate: ->
		@subscriptions.dispose()

	serialize: ->
