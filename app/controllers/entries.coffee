Spine = require('spine')
Entry = require('models/entry')

class EntriesPreview extends Spine.Controller
  className: 'preview'
  
  constructor: ->
    super
    Spine.bind('entry:change', @change)
    
  render: ->
    @html require('views/entries/preview')(@item)
    
  change: (@item) =>
    @render()

class EntriesList extends Spine.Controller
  className: 'list'
    
  events:
    'click .item': 'click'
  
  constructor: ->
    super
    Entry.bind('refresh change', @render)
    
  render: =>
    entries = Entry.all()
    @html require('views/entries')(entries)
    
  click: (e) ->
    item = $(e.target).item()
    Spine.trigger('entry:change', item)
    
class Entries extends Spine.Controller
  className: 'entries'
  
  constructor: ->
    super
    @list = new EntriesList
    @preview = new EntriesPreview
    
    @append @list, @preview
    
    Entry.fetch()
    
module.exports = Entries