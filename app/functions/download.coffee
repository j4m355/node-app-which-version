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

returnVersions = (url, applications, cb)->
	splitUrl = splitArray(url)
	appName = splitUrl[0]
	_.each(applications, (application)->
		if application.name.toLowerCase() == appName.toLowerCase()
			removedNameObject = _.omit(application, "name")
			justVersions = _.keys(removedNameObject)
			if justVersions is undefined then return []
			cb(justVersions)
			)
	cb(404)

exports.returnVersions = returnVersions


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