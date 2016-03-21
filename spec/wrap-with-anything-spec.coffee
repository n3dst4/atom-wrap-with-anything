#coffeelint: disable=max_line_length
WrapWithAnything = require '../lib/wrap-with-anything'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "WrapWithAnything", ->
  [workspaceElement, activationPromise] = []
  [editorElement, editor, buffer] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    waitsForPromise ->
      atom.packages.activatePackage('wrap-with-anything')
    waitsForPromise ->
      atom.workspace.open('wuthering.txt')
    runs ->
      editor = atom.workspace.getActiveTextEditor()
      editorElement = atom.views.getView(editor)
      {buffer} = editor

  it "inserts regular text insertions as normal", ->
    editor.insertText("parp")
    expect(editor.getText()).toMatch(/^parpI have just/)

  it "inserts magic characters as normal", ->
    editor.insertText("*")
    expect(editor.getText()).toMatch(/^\*I have just/)

  it "replaces selections as normal when you type a normal character", ->
    editor.scan(/misanthropist's/, ({range}) -> editor.setSelectedBufferRange(range))
    editor.insertText("x")
    expect(editor.getText()).toMatch(/perfect x heaven/)

  it "wraps selections when you type a magic character", ->
    editor.scan(/misanthropist's/, ({range}) -> editor.setSelectedBufferRange(range))
    editor.insertText("*")
    expect(editor.getText()).toMatch(/perfect \*misanthropist's\* heaven/)

  it "wraps multiple selections when you type a magic character", ->
    editor.scan(/from/g, (({range}) ->
      console.log range
      editor.addSelectionForBufferRange(range)))
    editor.insertText("*")
    expect(editor.getText()).toMatch(/returned \*from\* a visit/)
    expect(editor.getText()).toMatch(/removed \*from\* the stir/)

  it "responds to config changes", ->
    chars = atom.config.get("wrap-with-anything.chars")
    atom.config.set("wrap-with-anything.chars", "x")
    editor.scan(/from/g, (({range}) ->
      editor.addSelectionForBufferRange(range)))
    editor.insertText("x")
    expect(editor.getText()).toMatch(/returned xfromx a visit/)
    expect(editor.getText()).toMatch(/removed xfromx the stir/)
    atom.config.set("wrap-with-anything.chars", chars)
