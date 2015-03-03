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
YourHand = new Hand( TheCards.shuffle() )

console.log( YourHand, YourHand[0].suitName(), YourHand[0].valueName() )

console.log( YourHand.map( ( card, i ) ->
	return card.valueName() + ' of ' + card.suitName()
) )

# console.log( TheCards.cards[15], TheCards.cards[15].color() )