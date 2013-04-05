settings = require(__dirname + '/config/config')(__dirname + "/config/settings.json")

###
Skeleton generated with node-app-skeleton
git@github.com:j4m355/node-app-skeleton.git
START APPLICATION NOW :
###

express = require('express')
app = express()
exec = require('child_process').exec
downloadFunction = require('./functions/download')

app.get('apps', (req, res)->
	#send back a json list of just the app names so that dynamic routes can be created to a download page for each app
	)

app.get('*', (req, res)->
	requestedApplication = req.url
	console.log "req url: " + req.url
	if requestedApplication == "/"
		#this catches the mounted folder itself
		res.send(404)
	else
		downloadFileName = downloadFunction.returnCorrectVersionOfApp(requestedApplication, applications)
		console.log downloadFileName
		if downloadFileName == undefined
			res.send(404)
		else
			res.download(downloadFileName, (err)->
				if err then console.log err)
	)


applications = settings.get("applications")
app.listen(3400)
console.log('Listening on port 3400')
