settings = require(__dirname + '/config/config')(__dirname + "/config/settings.json")

###
Skeleton generated with node-app-skeleton
git@github.com:j4m355/node-app-skeleton.git
START APPLICATION NOW :
###

express = require('express')
app = express()
exec = require('child_process').exec
_ = require('underscore')

downloadFolder = __dirname + '/public/'

app.get('*', (req, res)->
	applicationVersion = ParseVersionFromUrl(req.url)
	console.log "req url: " + req.url
	console.log "application version: " + applicationVersion
	if applicationVersion == undefined
		res.download(downloadFolder + applications.default, (err) ->
			if err then console.log err)
	else
		downloadFileName = returnCorrectVersionOfApp(applicationVersion)
		console.log downloadFileName
		if downloadFileName == undefined
			res.send(404)
		else
			res.download(downloadFolder + downloadFileName, (err)->
				if err then console.log err)
	)

app.use(express.static(__dirname + '/public'));


app.listen(3400)
console.log('Listening on port 3400')


###
Stuff
###
applications = {}

ParseApplicationsFromSettings = ()->
	applications = settings.get("node-app-windows-launcher")

ParseVersionFromUrl = (url)->
	#checks for V and then number in url
	regexPattern = /^[Vv]{1}\d+$/
	lastSlash = url.lastIndexOf('/')
	result = url.substring(lastSlash + 1)
	if regexPattern.test(result)
		return result
	else
		return undefined

returnCorrectVersionOfApp = (version)->
	pairs = _.pairs(applications)
	file = undefined
	_.each(pairs, (item)->
		debugger
		if item[0].toLowerCase() == version.toLowerCase()
			file = item[1] 
		)
	debugger
	return file

ParseApplicationsFromSettings()
