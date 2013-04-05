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

app.get('/applications', (req, res)->
	res.send(downloadFunction.applicationNames(applications))
	)

app.get('*/versions', (req,res)->
	downloadFunction.returnVersions(req.url, applications, (versions)->
		console.log versions
		res.send(versions)
		)
	)

app.get('*', (req, res)->
	#first if is to stop any futher processing for the apps route above
	if req.url == '/apps' then res.send(200)
	requestedApplication = req.url
	console.log "req url: " + req.url
	if requestedApplication == "/"
		#this catches the mounted folder itself
		res.send(404)
	else
		downloadFileName = downloadFunction.returnCorrectVersionOfApp(requestedApplication, applications)
		if downloadFileName == undefined
			res.send(404)
		else
			res.download(downloadFileName, (err)->
				if err then console.log err)
	)


applications = settings.get("applications")
app.listen(3400)
console.log('Listening on port 3400')
