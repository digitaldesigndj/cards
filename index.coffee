'use strict'

Deck = require( './Deck' )

Hand = ( deck ) ->
	hand = []
	hand.push( deck[0] )
	hand.push( deck[1] )
	hand.push( deck[2] )
	hand.push( deck[3] )
	hand.push( deck[4] )
	return hand

TheCards = new Deck()

console.log( new Hand( TheCards.shuffle() ) )

# console.log( TheCards.cards[15], TheCards.cards[15].color() )