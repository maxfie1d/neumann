module.exports =
  class SuspiciousReasonModel
    constructor: (model) ->
      model.onSuspiciousLinesAttach ({editor: @editor, codeLines: @codeLines}) => @create()
      model.onSuspiciousLinesDetach (editor) => @destroy(editor)

    create: ->
      @handler = @editor?.onDidChangeCursorPosition (args) =>
        newPositionLine = args.newBufferPosition.row + 1
        codeLine = x for x in @codeLines when x.line == newPositionLine
        console.log codeLine.raw

    destroy: (editor) ->
      @handler?.dispose()
