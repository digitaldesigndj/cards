'use strict'

Deck = require( './Deck' )

Hand = ( deck ) ->
	hand = []
	# console.log deck.cards
	console.log( deck.cards.length )
	hand.push( deck.cards.shift() )
	hand.push( deck.cards.shift() )
	hand.push( deck.cards.shift() )
	hand.push( deck.cards.shift() )
	hand.push( deck.cards.shift() )
	console.log( deck.cards.length )
	return hand

# YourHand = new Hand( new Deck().shuffle() )
YourHand = new Hand( new Deck() )

# console.log( YourHand, YourHand[0].suit(), YourHand[0].value() )

# console.log( YourHand.map( ( card, i ) ->
# 	return card.value() + ' of ' + card.suit()
# ) )

# console.log( TheCards.cards[15], TheCards.cards[15].color() )