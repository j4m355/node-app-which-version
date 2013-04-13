nodemailer = require("nodemailer")
settings = require(__dirname + '/config')

emailSettings = settings.get("email:settings")
mailContent = settings.get("email:emailContent")

transport = nodemailer.createTransport("SMTP", emailSettings)

SendMail =  (email, cb)->
	mailContent.to = email
	transport.sendMail(mailContent, (error, responseStatus)->
		if error
			cb(error)
		else
			cb(200)
		)

exports.SendMail = SendMail