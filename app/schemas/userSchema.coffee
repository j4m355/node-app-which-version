mongoose = require('mongoose')
Schema = mongoose.Schema

User = new Schema(
  userEmail: String
  userHash: String
  userConfirmed: Boolean
  userRegisterDate: {type: Date, default: Date.now}
)
module.exports = mongoose.model('User', User)