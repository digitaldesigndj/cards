'use strict'

Deck = require( './Deck' )

Hand = require( './Hand' )

Poker = require( './Poker' )

Simple = require( './Simple' )

JacksOrBetter = new Poker()

Playa = new Simple()

credits = 1000
creditsNaked = 1000

reportHand = ( a_hand ) ->
	a_hand.cards.map( ( card, i ) ->
		return card.value() + ' of ' + card.suit()
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

	scoreNaked = JacksOrBetter.score( TheHand, bet )
	creditsNaked = creditsNaked - bet
	creditsNaked = creditsNaked + scoreNaked.win

	score = JacksOrBetter.score( Playa.play( TheHand ), bet )
	credits = credits - bet
	credits = credits + score.win

	# console.log( Playa.play( TheHand ) , TheHand )
	if JSON.stringify( score ) isnt JSON.stringify( scoreNaked )
		console.log( score, scoreNaked )
	console.log( credits, creditsNaked )

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

setInterval( playPoker, 1 )



# war = ( player1, player2 ) ->
# 	console.log( reportHand( player1 ) )
# 	console.log( reportHand( player2 ) )
# 	if player1.cards[0].rawValue == player2.cards[0].rawValue
# 		console.log( "WAR" )
# 	if player1.cards[0].rawValue > player2.cards[0].rawValue
# 		console.log( "Player1" )
# 	else
# 		console.log( "Player2" )

# play = () ->
# 	TheDeck = new Deck()
# 	TheDeck.shuffle()
# 	YourHand = new Hand(
# 		deck: TheDeck
# 		size: 1
# 	)
# 	MyHand = new Hand(
# 		deck: TheDeck
# 		size: 1
# 	)
# 	war( YourHand, MyHand )
# 	return

# setInterval( play, 1000 )
