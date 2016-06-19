module.exports = ->
  selection = atom.workspace.getActiveTextEditor()?.getSelectedScreenRange()

  console.log selection

  marker = atom.workspace.getActiveTextEditor()?.markBufferRange(selection)

  decoration = atom.workspace.getActiveTextEditor()?.decorateMarker(marker, {type: 'line', class: 'suspicious'})
