OptionEditorView = require  '../views/option-editor-view'

module.exports =
	class OptionEditorModel
		panel: null

		constructor: ->
			@view = new OptionEditorView

		toggle: ->
			if @isOptionEditorVisible()
				@hideOptionEditor()
			else
				@showOptionEditor()


		isOptionEditorVisible: ->
			return @panel? and @panel.isVisible()

		showOptionEditor: ->
			@panel ?= atom.workspace.addRightPanel(item: @view)

			@panel.show()
		hideOptionEditor: ->
			@panel.hide()
