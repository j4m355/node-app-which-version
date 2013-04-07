Database = require('../functions/database')
Application = require(__dirname + '/../schemas/applicationSchema')


###
Public Services
###
Applications = (cb)->
    GetApplications((Applications)->
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
    Update(applicationObj, (res)->
        cb(res)
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
        cb(result)
        )

GetSingle = (applicationName, cb)->
    application = new Application()
    Application.find(name : applicationName).exec((err, result)->
        cb(result)
        )

Create = (app, cb)->
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
    application.update({name : app.name }, app, {upsert: true}, (err, numAffected, rawResponse)->
        if err
            cb(err)
        else
            cb(200)
            )
