Database = require('../functions/database')
User = require(__dirname + '/../schemas/userSchema')
Hasher = require('../functions/hash')

###
Public Services
###
Login = (userDetails, cb)->
    GetUser(userDetails.userName, (user)->
        if user.length == 0
            cb(401)
        else if user.length > 1
            cb(502)
        else
            verified = Hasher.Verify(userDetails.userPassword, user[0].userHash)
            if verified
                cb(200)
            else
                cb(401)
        )
exports.Login = Login

CreateUser = (userDetails, cb) ->
    GetUser(userDetails.registerUser, (user)->
        if user.length > 0
            cb(409)
        else
            hashResult = Hasher.HashPassword(userDetails.registerPassword)
            delete userDetails.registerPassword
            userDetails.userHash = hashResult
            SaveUser(userDetails, (callback)->
                cb(200)
                )
            )
exports.CreateUser = CreateUser




###
Private Database Services
###
GetUser = (userName, cb)->
    user = new User()
    User.find(userName : userName).exec((err, result)->
        cb(result)
        )

SaveUser = (user, cb)->
    user = new User()
    user.userName  = user.registerUser
    user.userHash = user.userHash
    User.save((err)->
        if err
            cb(err)
        else
            cb(200)
            )
