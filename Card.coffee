'use strict'

Card = ( options ) ->
	@opts = options or {}
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
		suit: @opts.suit
		value: @opts.value
		suitName: () ->
			return suitNames[@suit]
		valueName: () ->
			return valueNames[@value]
		color: () ->
			console.log( @suit )
			if @suitName() == 'hearts' or @suitName() == 'diamonds'
				return 'red'
			else
				return 'black'
	return card

module.exports = Card