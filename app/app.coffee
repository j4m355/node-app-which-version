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



###add underscore to skeleton - add express branch###

downloadFolder = __dirname + '/public/'

app.get('/', (req, res)->
	###get the version request from the url params
	foreach on all the app versions in settings (how to deal with multi app here would it just be a new route or wheres it all mounted?)
	res.download the one in the list - 404 on not###
	applicationVersion = req.params.v
	if applicationVersion == undefined
		res.download(downloadFolder + applications.default, (err) ->
			console.log err)
	else
		pairsOfApplications = _.pairs(applications)
		_.each(pairsOfApplications, (item)->
			debugger
			console.log "bet it doesnt even get here"
			)
		
		res.download(downloadFolder + applicationVersion , (err) ->
			if err
				exec "sendEmailService \"Difficulty downloading windows service\"", (error, stdout, stderr) ->
					res.send stdout)
	)

app.use(express.bodyParser());
app.use(express.static(__dirname + '/public'));

app.listen(3400)
console.log('Listening on port 3400')


###
Stuff
###
applications = {}

ParseApplicationsFromSettings = ()->
	applications = settings.get("node-app-windows-launcher")
	debugger



ParseApplicationsFromSettings()
