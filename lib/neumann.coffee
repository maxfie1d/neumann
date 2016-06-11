exec = require('child_process').exec

NeumannView = require './neumann-view'
{CompositeDisposable} = require 'atom'

module.exports = Neumann =
  neumannView: null
  modalPanel: null
  subscriptions: null
  cmd: 'git log --oneline'

  activate: (state) ->
    @neumannView = new NeumannView(state.neumannViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @neumannView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view

    @subscriptions.add atom.commands.add 'atom-workspace', 'neumann:git-blame': => @gitBlameToggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @neumannView.destroy()

  serialize: ->
    neumannViewState: @neumannView.serialize()

  gitBlameToggle: ->
    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      exec @cmd, (err, stdout, stderr) =>
        if !err
          console.log(stdout)
          @neumannView.setText(stdout)
          @modalPanel.show()
        else
          console.log(stderr)
