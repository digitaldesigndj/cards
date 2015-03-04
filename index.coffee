'use strict'

Deck = require( './Deck' )

Hand = require( './Hand' )

# Game
Poker = require( './Poker' )
JacksOrBetter = new Poker()

# Play Strategies
Simple = require( './Simple' )
Optimal = require( './Optimal' )

Strategey = new Simple()
# Strategey = new Optimal()

credits = 0
creditsNaked = 0
spend = 0

reportHand = ( a_hand ) ->
	a_hand.cards.map( ( card, i ) ->
		return card.valueLetter() + card.unicodeSuit()
		# return card.rawValue + card.unicodeSuit()
	)

playPoker = ( ) ->
	TheDeck = new Deck()
	TheDeck.shuffle()
	TheHand = new Hand(
		deck: TheDeck
		size: 5
	)

	# Play Poker Here
	# score = Playa.play( TheHand )
	# console.log( score )


	# Score Poker
	bet = 5

	spend = spend + bet

	scoreNaked = JacksOrBetter.score( TheHand, bet )
	creditsNaked = creditsNaked - bet
	creditsNaked = creditsNaked + scoreNaked.win

	console.log( reportHand( TheHand ), scoreNaked )

	theGame = Strategey.play( TheHand )

	score = JacksOrBetter.score( theGame, bet )
	credits = credits - bet
	credits = credits + score.win

	console.log( reportHand( theGame ), score )

	console.log(
		'Credits: ' + credits
		'No Play: ' + creditsNaked
		'Spend: ' + spend
		'Hands Played: ' + spend/5
	)
	# console.log( Playa.play( TheHand ) , TheHand )
	# if JSON.stringify( score ) isnt JSON.stringify( scoreNaked )
		# console.log( score, scoreNaked )
	

	# if score.status is 'jacksbetter'
	# 	console.log( reportHand( TheHand ) , score )
	# if score.status is '2pair'
	# 	console.log( reportHand( TheHand ) , score )
	# if score.status is '3kind'
	# 	console.log( reportHand( TheHand ) , score )
	# if score.status is 'flush'
	# 	console.log( reportHand( TheHand ) , score )
	# if score.status is '4kind'
	# 	console.log( reportHand( TheHand ) , score )
	# if score.status is 'royalflush'
	# 	console.log( reportHand( TheHand ) , score )
	# if score.status is 'straightflush'
	# 	console.log( reportHand( TheHand ) , score )
	# if score.status is 'straight'
	# 	console.log( reportHand( TheHand ) , score )

playPoker()

setInterval( playPoker, 0 )
