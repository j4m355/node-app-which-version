Database = require('../functions/database')
Application = require(__dirname + '/../schemas/applicationSchema')
_ = require("underscore")


###
Public Services
###
Applications = (cb)->
    GetAll((Applications)->
        debugger
        cb(Applications)        
        )
exports.Applications = Applications

Versions = (applicationName, cb) ->
    GetVersions(applicationName, (application)->
        if application.length is 0
            cb(404)
        else
            cb(application.versions)
            )
exports.Versions = Versions

Add = (applicationObj, cb) ->
    console.log "adding"
    GetSingle(applicationObj.name, (application)->
        console.log "tried to get single"
        debugger
        if application.length == 0
            console.log "trying to create a new record"
            Create(applicationObj, (result)->
                cb(result))
        else
            console.log "going to update a record"
            _.each(applicationObj.versions, (app)->
                application.versions.push(app)
                )
            Update(application, (result)->
                cb(result)
                )
        )

exports.Add = Add




###
Private Database Services

AddApplication
AddVersion
GetApplications

###

GetAll = (cb)->
    application = new Application()
    Application.find().exec((err, result)->
        debugger
        cb(result)
        )

GetSingle = (applicationName, cb)->
    application = new Application()
    Application.find(name : applicationName).exec((err, result)->
        cb(result)
        )

Create = (app, cb)->
    debugger
    application = new Application()
    application.name  = app.name
    application.versions = app.versions
    application.description = app.description
    application.save((err)->
        if err
            cb(err)
        else
            cb(200)
            )

Update = (app, cb)->
    application = new Application()
    application.update({name : app.name }, app, (err, numAffected, rawResponse)->
        if err
            cb(err)
        if numAffected == 0
            cb(rawResponse)
        else
            cb(200)
            )
