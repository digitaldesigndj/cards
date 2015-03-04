'use strict'

Deck = require( './Deck' )

Hand = require( './Hand' )

reportHand = ( a_hand ) ->
	a_hand.cards.map( ( card, i ) ->
		return card.value() + ' of ' + card.suit()
	)

# Game

war = ( player1, player2 ) ->
	console.log( reportHand( player1 ) )
	console.log( reportHand( player2 ) )
	if player1.cards[0].rawValue == player2.cards[0].rawValue
		console.log( "WAR" )
	if player1.cards[0].rawValue > player2.cards[0].rawValue
		console.log( "Player1" )
	else
		console.log( "Player2" )

play = () ->
	TheDeck = new Deck()
	TheDeck.shuffle()
	YourHand = new Hand(
		deck: TheDeck
		size: 1
	)
	MyHand = new Hand(
		deck: TheDeck
		size: 1
	)
	war( YourHand, MyHand )
	return

setInterval( play, 1000 )
