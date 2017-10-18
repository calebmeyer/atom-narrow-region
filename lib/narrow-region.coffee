NarrowRegionView = require './narrow-region-view'
{CompositeDisposable} = require 'atom'

module.exports = NarrowRegion =
  narrowRegionView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @narrowRegionView = new NarrowRegionView(state.narrowRegionViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @narrowRegionView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'narrow-region:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @narrowRegionView.destroy()

  serialize: ->
    narrowRegionViewState: @narrowRegionView.serialize()

  toggle: ->
    console.log 'NarrowRegion was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
