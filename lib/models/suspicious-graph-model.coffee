module.exports =
  class suspiciousGraphModel
    constructor: ->

    invoke: ->
      editor = atom.workspace.getActiveTextEditor()
      return unless editor?

      uri = "neumann://suspicious-graph/#{editor.id}"
      atom.workspace.open(uri)
