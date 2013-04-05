settings = require(__dirname + '/config/config')(__dirname + "/config/settings.json")

###
Skeleton generated with node-app-skeleton
git@github.com:j4m355/node-app-skeleton.git
START APPLICATION NOW :
###

flatiron = require('flatiron')
app = flatiron.app
app.use(flatiron.plugins.http)
exec = require('child_process').exec

downloadFunction = require('./functions/download')

app.router.get('/applications', (req, res)->
	res.send(downloadFunction.applicationNames(applications))
	)

app.router.post('/add', (req, res)->
	###
	need a smart way to reload applications from settings.json
	###
	)

app.router.get('*/versions', (req,res)->
	downloadFunction.returnVersions(req.url, applications, (versions)->
		res.send(versions)
		)
	)

app.router.get('*', (req, res)->
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
app.start(3400)
console.log('Listening on port 3400')
