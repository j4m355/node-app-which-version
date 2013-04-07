mongoose = require("mongoose")
settings = require(__dirname + '/config') 

module.exports = () ->
    mongoose.connect settings.get("database:host"), settings.get("database:name")
    mongoose



