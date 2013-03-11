settings = require(__dirname + '/config/config')(__dirname + "/config/settings.json")

###
Skeleton generated with node-app-skeleton
git@github.com:j4m355/node-app-skeleton.git
START APPLICATION NOW :
###

express = require('express')
app = express()
exec = require('child_process').exec

app.get('/', (req, res)->
	exec "sendEmailService \"#{req.connection.remoteAddress} has downloaded the service\"", (error, stdout, stderr) ->
			console.log stdout	
	res.download(__dirname + '/public/Node-App-Windows-Launcher.exe', (err) ->
		if err
			exec "sendEmailService \"Difficulty downloading windows service\"", (error, stdout, stderr) ->
				res.send stdout)
	)

app.use(express.static(__dirname + '/public'));

app.listen(3400)
console.log('Listening on port 3400')