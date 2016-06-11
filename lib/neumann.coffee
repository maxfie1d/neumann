NeumannView = require './neumann-view'
{CompositeDisposable} = require 'atom'

module.exports = Neumann =
  neumannView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @neumannView = new NeumannView(state.neumannViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @neumannView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'neumann:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @neumannView.destroy()

  serialize: ->
    neumannViewState: @neumannView.serialize()

  toggle: ->
    console.log 'Neumann was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
