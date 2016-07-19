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
			order: 2
			description: 'git path'
		# 使用するアルゴリズムの設定
		algorithm:
			type: 'string'
			default: "Neumann Algorithm"
			order: 1
			description: "Select algorithm to use."
			enum: [
				"Neumann Algorithm",
				"Random Algorithm"
			]
		# ノイマンアルゴリズムで使用するルールを選択
		neumannAlgorithmSettings:
			title: "Neumann Algorithm settings"
			type: 'object'
			collapsed: false
			order: 99
			description: "Select rules which used in Neumann Algorithm to evaluate codes."
			properties:
				isMidnightRuleEnabled:
					title: "Midnight rule"
					description: "Codes written at night are suspicious."
					type: 'boolean'
					order: 1
					default: true
				isUnreliableMembersRuleEnabled:
					title: "Unreliable members rule"
					description: "Codes written by unreliable members are suspicious."
					type: 'boolean'
					order: 2
					default: true
				# 信頼できないメンバーの設定
				unreliableMembers:
					title: "Unreliable members"
					type: 'array'
					default: []
					items:
						type: 'string'
					order: 2
					description: "Unreliable members (comma-separated string)"
				isEditHistoryRuleEnabled:
					title: "Edit history rule"
					description: "Recently edited codes are more suspicious."
					type: 'boolean'
					order: 3
					default: true
				isNotCommittedRuleEnabled:
					title: "Not committed rule"
					description: "Notify if the code is not yet commited."
					type: 'boolean'
					order: 4
					default: true


	subscriptions: null

	# neumann起動時にこのメソッドが呼ばれます
	activate: (state) ->
		@subscriptions = new CompositeDisposable

		# Register command that toggles this view
		@subscriptions.add atom.commands.add 'atom-workspace', 'neumann:git-blame': -> GitBlame()

		suspiciousnessGraphModel = new SuspiciousnessGraphModel()
		@subscriptions.add atom.commands.add 'atom-workspace', 'neumann:suspiciousness-graph': -> suspiciousnessGraphModel.toggle()

		# 各TextEditorに対してModelを作る
		atom.workspace.observeTextEditors (editor) ->
			model = new SuspiciousLinesModel(editor)
			new SuspiciousnessReasonModel(model)

		# Suspiciousness Graphのカスタムオープナーを定義
		atom.workspace.addOpener (uri) ->
			# uriを処理
			try
				url = require 'url'
				{protocol, host, path} = url.parse(uri)
			catch error
				return

			# プロトコルがneumann:でなければ何もしない
			return unless protocol is 'neumann:'

			# pathを処理
			try
				path = decodeURI(path)
			catch error
				return

			return new SuspiciousnessGraphView(editorId: path.substring(1))


	deactivate: ->
		@subscriptions.dispose()

	serialize: ->
