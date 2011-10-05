Spine = require('spine')

class Entry extends Spine.Model
  @configure 'Entry', 'title', 'href', 'author', 'score', 'date'
  
  @extend Spine.Model.Local
  
module.exports = Entry
