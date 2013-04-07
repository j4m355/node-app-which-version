mongoose = require('mongoose')
Schema = mongoose.Schema
Mixed = mongoose.SchemaTypes.Mixed

Applications = new Schema(
  name: String
  versions: [{versionName: String, versionPath: String, versionVerified: {type : Boolean, default: false }, versionDescription: {type : String, default: ""}, versionOperatingSystem: {type: String, default: "Windows"}}]
  description: {type: String, default: "Download versions here"}
)
module.exports = mongoose.model('Applications', Applications)