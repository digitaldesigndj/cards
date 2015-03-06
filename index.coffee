'use strict'

fs = require('fs')

Deck = require( './Deck' )
Hand = require( './Hand' )
# Game
Poker = require( './Poker' )
# Play Strategies
Simple = require( './Simple' )
Optimal = require( './Optimal' )

JacksOrBetter = new Poker()
Strategey = new Simple()
# Strategey = new Optimal()

credits = 0
creditsNaked = 0
spend = 0

reportHand = ( a_hand ) ->
	# console.log( a_hand )
	if a_hand.type == 'strategy'
		a_hand = a_hand.hand
	a_hand.cards.map( ( card, i ) ->
		return card.valueLetter() + card.unicodeSuit()
		# return card.rawValue + card.unicodeSuit()
	)

playPoker = ( stream ) ->
	TheDeck = new Deck()
	TheDeck.shuffle()
	TheHand = new Hand(
		deck: TheDeck
		size: 5
	)

	# Score Poker
	bet = 5

	spend = spend + bet

	# scoreNaked = JacksOrBetter.score( TheHand, bet )
	# creditsNaked = creditsNaked - bet
	# creditsNaked = creditsNaked + scoreNaked.win

	stream.write( reportHand( TheHand ) + "\n" )

	theGame = Strategey.play( TheHand )
	# console.log( )
	# console.log( theGame, 'sumtin', theGame.hand )

	stream.write( reportHand( theGame ) + "\n" )

	score = JacksOrBetter.score( TheHand, bet )
	credits = credits - bet
	credits = credits + score.win

	stream.write( JSON.stringify( score ) + "\n" )

# module.exports = playPoker

awesome = () ->
	stream = fs.createWriteStream( Math.round(new Date().getTime()/1000.0) + '.txt')
	stream.once('open', (fd)->
		[1..2000].map ( i ) ->
			playPoker( stream )
		stream.write( 'Credits: ' + credits + '\n' )
		# stream.write( 'No Play: ' + creditsNaked + '\n' )
		stream.write( 'Spend: ' + spend + '\n' )
		stream.write( 'Hands Played: ' + spend/5 + '\n' )
		stream.end()
	)


setInterval( awesome, 2000 )
