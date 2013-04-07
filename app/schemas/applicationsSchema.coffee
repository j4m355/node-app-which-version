mongoose = require('mongoose')
Schema = mongoose.Schema
Mixed = mongoose.SchemaTypes.Mixed

Applications = new Schema(
  name: String
  versions: [{versionName: String, versionPath: String, verified: {type : Boolean, default: false }}]
  description: {type: String, default: @.name}
)
module.exports = mongoose.model('Applications', Applications)