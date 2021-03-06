path = require 'path'
_ = require 'underscore-plus'
ImageEditor = require './image-editor'

module.exports =
  activate: ->
    @openerDisposable = atom.workspace.addOpener(openURI)

  deactivate: ->
    @openerDisposable.dispose()

  consumeStatusBar: (statusBar) ->
    ImageEditorStatusView = require './image-editor-status-view'
    view = new ImageEditorStatusView(statusBar)
    view.attach()

# Files with these extensions will be opened as images
imageExtensions = ['.gif', '.ico', '.jpeg', '.jpg', '.png', '.webp']
openURI = (uriToOpen) ->
  uriExtension = path.extname(uriToOpen).toLowerCase()
  if _.include(imageExtensions, uriExtension)
    new ImageEditor(uriToOpen)
