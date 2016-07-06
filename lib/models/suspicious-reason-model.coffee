module.exports =
  class SuspiciousReasonModel
    constructor: (model) ->
      model.onSuspiciousLinesAttach (editor) => @create(editor)
      model.onSuspiciousLinesDetach (editor) => @destroy(editor)

    create: (editor) ->
      @handler = editor?.onDidChangeCursorPosition (args) ->
        newPosition = args.newBufferPosition.row
        console.log "#{newPosition+1}行目"

    destroy: (editor) ->
      @handler?.dispose()
