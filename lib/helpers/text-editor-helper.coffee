module.exports = TextEditorHelper =
  # editorIdに一致するTextEditorがあれば返す
  getEditorForId: (editorId) ->
    for editor in atom.workspace.getTextEditors()
      return editor if editor.id.toString() is editorId.toString()

    return null
