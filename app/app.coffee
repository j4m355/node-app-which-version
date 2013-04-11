settings = require(__dirname + '/functions/config') 

###
Skeleton generated with node-app-skeleton
git@github.com:j4m355/node-app-skeleton.git
START APPLICATION NOW :
###

express = require('express')
app = express()
exec = require('child_process').exec
downloadFunction = require('./functions/download')
applicationService = require('./services/applicationService')

app.use(express.bodyParser())

app.get('/applications', (req, res)->
	console.log "Gravy"
	applicationService.Applications((result, cb)->
		debugger
		res.send(result)
		)
	)

app.post('/add', (req, res)->
	if req.body != undefined
		applicationService.Add(req.body, (cb)->
			res.send(cb))
	)


app.get('*', (req, res)->
	#first if is to stop any futher processing for the apps route above
	if req.url == '/applications' then res.send(200)
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
app.listen(3403)
console.log('Listening on port 3403')
