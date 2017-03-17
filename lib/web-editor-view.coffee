module.exports =
class WebEditorView
    constructor: (serializedState) ->
        console.log serializedState

        # Create root element
        @element = document.createElement 'iframe'
        @relocate 'http://musicforprogramming.net/'

    relocate: (source) ->
        @element.setAttribute('src', source)

    # This is the tab Title and it is required.
    getTitle: () ->
        return 'Music for Programming'

    destroy: ->
        @element.remove()

    # Also required. (allows pane/panel to access it)
    getElement: ->
        @element
