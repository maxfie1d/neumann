{CompositeDisposable} = require 'atom'
GitBlame = require './models/git-blame'

module.exports = Neumann =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'neumann:git-blame': -> GitBlame()

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->
