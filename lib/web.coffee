# atom clean up work
{CompositeDisposable} = require 'atom'

# included modules
WebEditorView = require './web-editor-view'

# universal resource link (parser)
url = require 'url'

module.exports =
    activate: (state) ->
        @disposable =
            new CompositeDisposable()

        pane = atom.workspace.getActivePane()

        subscription =
            atom.commands.add 'atom-workspace',
            'music-for-programming:open': => @open()
            'music-for-programming:close': => @close()
            'music-for-programming:reload': => @reload()
            'music-for-programming:toggle': => @toggle()

        @disposable.add atom.workspace.addOpener (uri) ->
            return new WebEditorView() if uri is "view://web"

        @disposable.add atom.views.addViewProvider WebEditorView

        @editor = editor =
            atom.workspace.buildTextEditor()

        @disposable.add subscription

    deactivate: ->
        @disposable.dispose()

    reload: (event) ->
        pane = @getPane()

        if pane.activeItem instanceof WebEditorView
            pane.activeItem.element.contentWindow.location.reload()

    open: ->
        # if not already opened - getTitle?
        atom.workspace.open("view://web")

        atom.views.getView(@editor).focus()

        console.log(atom.workspace.getPanes())
        console.log("getPanes()[0].items[2]: " + atom.workspace.getPanes()[0].items[1]["activePanel"].name)
        console.log("getPanes()[0].items[2]: " + atom.workspace.getPanes()[0].items.length)
        # console.log("getPanes()[0].items[2]: " + atom.workspace.getPanes()[0].activeItem[0])
        # console.log(atom.workspace.getPanes()[0].items[2].element.src)
        # console.log(atom.workspace.getPanes()[0].activeItem().element.src)

        # https://github.com/MiracleBlue/atom-dedupe-open-files/blob/master/lib/dedupe-open-files.js
        console.log(atom.textEditors.editors)
        # console.log(atom.textEditors.editors.values().next().value)
        # console.log(atom.textEditors.editors.entries().next().value)
        # console.log(atom.textEditors.editors.entries().next().value[0])
        # console.log(atom.textEditors.editors[0].editorElement.title)

    close: ->
        pane = @getPane()

        if pane.activeItem instanceof WebEditorView
            # https://github.com/smockle/close-other-tabs/blob/master/lib/close-other-tabs.coffee
            tabBar = atom.views.getView(atom.workspace.getPanes()[0])

            # https://github.com/atom/tabs/blob/3b4124593b42dcdf003c0ac9a7e6c50fea34e11f/lib/tab-bar-view.coffee#L17-L23
            atom.commands.dispatch(tabBar, 'tabs:close-tab')

    toggle: ->
        pane = @getPane()

        if pane.activeItem instanceof WebEditorView
            @close()
        else
            @open()

    checkIfAlreadyOpen: ->
        pane = @getPane()

        titleOrig = "musicForProgramming"
        titleDoc = pane.activeItem.element.contentDocument.title

        console.log(atom.workspace.getActivePane())
        console.log(titleDoc)
        
        if titleDoc.match(titleOrig)
            console.log("matches")

    getPane: ->
        return atom.workspace.getActivePane()