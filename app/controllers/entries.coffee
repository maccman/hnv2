Spine = require('spine')
Entry = require('models/entry')
List  = require('lib/list')

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
  
  constructor: ->
    super
    @list = new List(el: @el, selectFirst: true, template: @template)
    @list.bind 'change', (item) -> Spine.trigger('entry:change', item)
    Entry.bind('refresh change', @render)
  
  template:
    require('views/entries')
    
  render: =>
    entries = Entry.all()
    @list.render(entries)
    
class Entries extends Spine.Controller
  className: 'entries'
  
  constructor: ->
    super
    @list = new EntriesList
    @preview = new EntriesPreview
    
    @append @list, @preview
    
    Entry.fetch()
    
module.exports = Entries