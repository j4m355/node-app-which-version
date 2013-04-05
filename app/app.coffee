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



app.get('*', (req, res)->
	###get the version request from the url params
	foreach on all the app versions in settings (how to deal with multi app here would it just be a new route or wheres it all mounted?)
	res.download the one in the list - 404 on not###
	requestedApplication = req.url
	console.log "req url: " + req.url
	if requestedApplication == "/"
		#this catches the mounted folder itself
		res.send(404)
	else
		downloadFileName = returnCorrectVersionOfApp(requestedApplication)
		console.log downloadFileName
		if downloadFileName == undefined
			res.send(404)
		else
			res.download(downloadFileName, (err)->
				if err then console.log err)
	)

#app.use(express.bodyParser());
app.use(express.static(__dirname + '/public'))


app.listen(3400)
console.log('Listening on port 3400')

###
Stuff
###
applications = {}

ParseApplicationsFromSettings = ()->
	applications = settings.get("applications")


returnCorrectVersionOfApp = (url)->
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

splitArray = (url) ->
	urlArray = url.split('/')
	urlArray.splice(0,1)
	return urlArray	
	


ParseApplicationsFromSettings()


