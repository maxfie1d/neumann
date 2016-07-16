SuspiciousnessGraphView = require '../views/suspiciousness-graph-view'

module.exports =
	class SuspiciousnessGraphModel
		constructor: ->

		toggle: ->
			# すでにグラフ画面がアクティブなら閉じる
			if atom.workspace.getActivePaneItem() instanceof SuspiciousnessGraphView
				atom.workspace.destroyActivePaneItem()
				return

			# アクティブなEditorが存在しなければ何もしない
			editor = atom.workspace.getActiveTextEditor()
			return unless editor?

			# TextEditorに対応するグラフがあれば閉じ，
			# なければグラフを表示
			if @graphForEditorExists(editor)
				@removeGraph(editor)
			else
				@addGraph(editor)

		# グラフのURIを返します
		graphUri: (editor) ->
			"neumann://suspiciousness-graph/#{editor.id}"

		# editorに対するグラフがすでにあるかどうかを返します
		graphForEditorExists: (editor) ->
			uri = @graphUri(editor)
			graphPane = atom.workspace.paneForURI(uri)
			return graphPane?

		# editorに対するグラフを追加します
		addGraph: (editor) ->
			uri = @graphUri(editor)
			activePane = atom.workspace.getActivePane()
			# グラフを右側に開く
			atom.workspace.open(uri, {split: 'right', searchAllPanes: true}).then (view) ->
				# グラフを開いたらフォーカスを元に戻す
				if view instanceof SuspiciousnessGraphView
					activePane.activate()

		# editorに対するグラフを削除します
		removeGraph: (editor) ->
			uri = @graphUri(editor)
			graphPane = atom.workspace.paneForURI(uri)
			graphPane.destroyItem(graphPane.itemForURI(uri))
