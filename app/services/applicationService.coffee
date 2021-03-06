Database = require('../functions/database')
Application = require(__dirname + '/../schemas/applicationSchema')
_ = require("underscore")


###
Public Services
###
Applications = (cb)->
    GetAll((Applications)->
        debugger
        console.log Applications
        cb(Applications)        
        )
exports.Applications = Applications

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

GetApplication = (url, cb)->
    parsedUrl = splitArray(url)
    if parsedUrl is undefined then cb(undefined)
    file = undefined
    GetSingle(parsedUrl[0], (res)->
        if res.length is 0 then cb(undefined)
        for app in res[0].versions
            if app.versionName.toLowerCase() == parsedUrl[1].toLowerCase()
                return cb(app.versionPath)
        
        ) 

exports.GetApplication = GetApplication

UpdateApplication = (applicationObj, cb)->
    Update(applicationObj, (res)->
        cb(res)
        )

exports.Update = Update




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




###
private methods
###

splitArray = (url) ->
    #check first char and last are slashes
    unless endsWith(url, "/")
        url = url + '/'
    unless url.lastIndexOf("/", 0) == 0
        url = "/" + url
    urlArray = url.split('/')
    urlArray.splice(0,1)
    return urlArray
    
        

applicationNames = (applications)->
    appArray = []
    _.each(applications, (app)->
        appArray.push(app.name)
        )
    return appArray

exports.applicationNames = applicationNames

endsWith = (str, suffix) ->
  str.indexOf(suffix, str.length - suffix.length) isnt -1
