Database = require('../functions/database')
Logger = require(__dirname + '/../schemas/loggerSchema')


SaveToLog = (req, additionalInfo, cb)->
    logger = new Logger()
    logger.date = new Date()
    logger.url = req.url
    logger.method = req.method
    logger.eventDetails = additionalInfo
    logger.requestBody = req.body
    logger.save((err)->
        if err
            cb(err)
        else
            cb(200)
            )

exports.SaveToLog = SaveToLog