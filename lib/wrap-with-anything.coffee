#coffeelint: disable=max_line_length
module.exports = WrapWithAnything =
  config:
    chars:
      title: "Characters to wrap *selections* in"
      type: "string"
      default: "*~/_ "

  activate: (state) ->
    atom.config.observe 'wrap-with-anything.chars', (chars) =>
      console.log "Got observed chars as " + chars
      @chars = chars

    atom.workspace.observeTextEditors (editor) =>
      editorElement = atom.views.getView(editor)
      editor.onWillInsertText ({text, cancel}) =>
        return unless @isMatchingChar text
        selections = editor.getSelections().filter((s) ->  ! s.isEmpty())
        if selections.length > 0
          cancel()
          selections.forEach (selection) ->
            range = selection.getBufferRange()
            selection.insertText text + selection.getText() + text, {select: true}
            options = reversed: selection.isReversed()
            selectionStart = range.start.traverse([0, 1])
            if range.start.row is range.end.row
              selectionEnd = range.end.traverse([0, 1])
            else
              selectionEnd = range.end
            selection.setBufferRange([selectionStart, selectionEnd], options)

  isMatchingChar: (char) ->
    return char.length == 1 && @chars.indexOf(char) > -1
