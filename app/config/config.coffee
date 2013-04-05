nconf = require('nconf')
classLevelPath = ""

module.exports = (path) ->
	classLevelPath = path
	nconf.use 'file', file: path
	nconf.load()
	nconf

reload = () ->
	console.log classLevelPath
	nconf.use 'file', file: classLevelPath
	nconf.load()
	nconf

exports.reload = reload
