_ = require('underscore')

returnCorrectVersionOfApp = (url, applications)->
	parsedUrl = splitArray(url)
	if parsedUrl is undefined then return undefined
	file = undefined
	for app in applications
		if app.name.toLowerCase() == parsedUrl[0].toLowerCase()
			pairs = _.pairs(app)
			_.each(pairs, (pair)->
				if pair[0].toLowerCase() == parsedUrl[1].toLowerCase()
					file = pair[1]
					)
	return file

exports.returnCorrectVersionOfApp = returnCorrectVersionOfApp

splitArray = (url) ->
	urlArray = url.split('/')
	urlArray.splice(0,1)
	return urlArray

