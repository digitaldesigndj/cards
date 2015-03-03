Card = require( './Card' )

Deck = ( options ) ->
	@opts = options or {}
	@suits = [
		'clubs'
		'diamonds'
		'hearts'
		'spades'
	]
	@values = [
		'ace'
		'two'
		'three'
		'four'
		'five'
		'six'
		'seven'
		'eight'
		'nine'
		'ten'
		'jack'
		'queen'
		'king'
	]
	@cards = @init()
	return @

Deck::init = ( ) ->
	self = @
	deck = self.suits.map( ( suit, i ) ->
		self.values.map( ( value, val_i ) -> 
			return new Card(
				suit: suit
				value: value
			)
		)
	)
	.reduce( ( a, b ) ->
		return a.concat( b )
	)

Deck::shuffle = ( ) ->
	array = @cards
	counter = array.length
	temp = undefined
	index = undefined
	while counter > 0
		index = Math.random() * counter-- | 0
		temp = array[counter]
		array[counter] = array[index]
		array[index] = temp
	return array

module.exports = Deck