#coffeelint: disable=max_line_length
WrapWithAnything = require '../lib/wrap-with-anything'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "WrapWithAnything", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('wrap-with-anything')

  describe "regular character insertions", ->
    it "should be unaffected", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      expect(workspaceElement.querySelector('.wrap-with-anything')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'wrap-with-anything:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.wrap-with-anything')).toExist()

        wrapWithAnythingElement = workspaceElement.querySelector('.wrap-with-anything')
        expect(wrapWithAnythingElement).toExist()

        wrapWithAnythingPanel = atom.workspace.panelForItem(wrapWithAnythingElement)
        expect(wrapWithAnythingPanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'wrap-with-anything:toggle'
        expect(wrapWithAnythingPanel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.wrap-with-anything')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'wrap-with-anything:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        wrapWithAnythingElement = workspaceElement.querySelector('.wrap-with-anything')
        expect(wrapWithAnythingElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'wrap-with-anything:toggle'
        expect(wrapWithAnythingElement).not.toBeVisible()
