{CompositeDisposable} = require 'atom'
git = require '../git'
SuspiciousLinesView = require '../views/suspicious-lines-view'

module.exports =
  class SuspiciousLinesModel
    constructor: (@editor) ->
      @subscriptions = new CompositeDisposable

      # コマンドを登録
      @subscriptions.add atom.commands.add atom.views.getView(@editor), 'neumann:suspicious-lines': => @invoke()

      @view = new SuspiciousLinesView(@editor)

    invoke: =>
      git.blame()
      .then (output) =>
        @view.create(output)
      .catch (e) ->
        console.log e
