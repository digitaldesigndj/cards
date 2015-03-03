'use strict'

Card = ( options ) ->
	@opts = options or {}
	@opts.suit = options.suit or 0
	@opts.value = options.value or 0
	suitNames = [
		'hearts'
		'diamonds'
		'clubs'
		'spades'
	]
	valueNames =[
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
	card = 
		rawSuit: @opts.suit
		rawValue: @opts.value
		suit: () ->
			return suitNames[@rawSuit]
		value: () ->
			return valueNames[@rawValue]
		color: () ->
			console.log( @rawSuit )
			if @suit() == 'hearts' or @suit() == 'diamonds'
				return 'red'
			else
				return 'black'
	return card

module.exports = Card