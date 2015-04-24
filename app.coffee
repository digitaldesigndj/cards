'use strict'
Hapi = require( 'hapi' )

Deck = require( './Deck' )
Hand = require( './Hand' )
# Game
Poker = require( './Poker' )
# Play Strategies
Simple = require( './Simple' )

JacksOrBetter = new Poker()
Strategey = new Simple()

reportHand = ( a_hand ) ->
	# console.log( a_hand )
	if a_hand.type == 'strategy'
		a_hand = a_hand.hand
	a_hand.cards.map ( card, i ) ->
		return card.valueLetter() + card.unicodeSuit()
		# return card.rawValue + card.unicodeSuit()

playPoker = ( credits, spend, bet ) ->
	TheDeck = new Deck()
	TheDeck.shuffle()
	TheHand = new Hand(
		deck: TheDeck
		size: 5
	)
	game = {}
	game.spend = spend + bet
	game.draw = reportHand( TheHand )
	theGame = Strategey.play( TheHand )
	game.play = reportHand( theGame )
	game.score = JacksOrBetter.score( TheHand, bet )
	credits = credits - bet
	game.credits = credits + game.score.win
	return game


server = new Hapi.Server
	debug:
		request: ['error']

server.connection
	# host: 'taylor.hyprtxt.com'
	host: 'localhost'
	port: 3000

server.route
	method: 'GET'
	path: '/{hands}/{bet}'
	handler: ( request, reply ) ->
		results = {}
		results.games = []
		credits = 0
		spend = 0
		bet = encodeURIComponent(request.params.bet)
		hands = encodeURIComponent(request.params.hands)
		[1..hands].map ( i ) ->
			game = playPoker( 0, 0, bet )
			credits = credits + game.credits
			spend =  spend + parseInt( game.spend )
			results.games.push( game )
		results.credits = credits
		results.spend = spend
		results.hands = parseInt( hands )
		reply( results )
			.header( 'Content-Type', 'application/json')
			.header( 'Access-Control-Allow-Origin', '*')

# Event Logging, to the console
server.register
	register: require('good')
	options:
		opsInterval: 1000
		reporters: [
			reporter: require('good-console')
			args: [
				log: '*'
				response: '*'
			]
		]
, ( err ) ->
	return

server.start () ->
	console.info('Server started at ' + server.info.uri + "\n" + 'do this: /{hands}/{bet}')