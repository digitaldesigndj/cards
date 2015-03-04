'use strict'

Card = require( './Card' )

Player = ( options ) ->
	@opts = options or {}
	@hand = options.hand or {}
	@opts.handsPerDay = options.handsPerDay or 5000
	@opts.speedModifier = options.speedModifier or 1
	return @

Player::init = ( ) ->
	self = @
	deck = self.suits.map( ( suit, i ) ->
		return self.values.map( ( value, val_i ) -> 
			return new Card(
				suit: suit
				value: value
			)
		)
	)
	.reduce( ( a, b ) ->
		return a.concat( b )
	)
	return deck

Player::shuffle = ( ) ->
	array = @cards
	counter = array.length
	temp = undefined
	index = undefined
	while counter > 0
		index = Math.random() * counter-- | 0
		temp = array[counter]
		array[counter] = array[index]
		array[index] = temp
	@shuffled = true
	return array

Player::draw = ( ) ->
	return @cards.shift()


module.exports = Player