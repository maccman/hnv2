Spine = require('spine')

class Entry extends Spine.Model
  @configure 'Entry', 'title', 'href'
  
  @extend Spine.Model.Local
  
module.exports = Entry