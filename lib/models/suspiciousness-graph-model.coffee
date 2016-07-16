SuspiciousnessGraphView = require '../views/suspiciousness-graph-view'

module.exports =
	class SuspiciousnessGraphModel
		constructor: ->

		toggle: ->
			# すでにグラフ画面がアクティブなら閉じる
			if atom.workspace.getActivePaneItem() instanceof SuspiciousnessGraphView
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
			"neumann://suspiciousness-graph/#{editor.id}"

		graphForEditorExists: (editor) ->
			uri = @graphUri(editor)
			graphPane = atom.workspace.paneForURI(uri)
			return graphPane?

		addGraph: (editor) ->
			uri = @graphUri(editor)
			activePane = atom.workspace.getActivePane()
			# グラフを右側に開く
			atom.workspace.open(uri, {split: 'right', searchAllPanes: true}).then (view) ->
				# グラフを開いたらフォーカスを元に戻す
				if view instanceof SuspiciousnessGraphView
					activePane.activate()

		removeGraph: (editor) ->
			uri = @graphUri(editor)
			graphPane = atom.workspace.paneForURI(uri)
			graphPane.destroyItem(graphPane.itemForURI(uri))
