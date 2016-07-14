OptionView = require  '../views/option-view'

module.export = ->
  class optionViewModel
    constructor: ->

    toggle: ->
      # すでにグラフ画面がアクティブなら閉じる
			if atom.workspace.getActivePaneItem() instanceof OptionView
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
