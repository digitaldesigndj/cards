cluster = require('cluster')
app = require('./index')

app()

cluster( app )
	# .use(cluster.logger('logs'))
	# .use(cluster.stats())
	# .use(cluster.pidfiles('pids'))
	# .use(cluster.repl(8888))
	# .use(cluster.cli())
	# .listen(3000)