'use strict'

Card = require( './Card' )

Player = ( options ) ->
	@opts = options or {}
	@opts.hand = options.hand or {}
	@opts.credits = options.credits or 100
	@opts.spend = options.spend or 0
	@opts.name = options.name or 21
	@opts.age = options.age or 21
	@opts.handsPerDay = options.handsPerDay or 5000
	@opts.speedModifier = options.speedModifier or 1
	return @

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