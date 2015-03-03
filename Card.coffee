'use strict'

Card = ( options ) ->
	@opts = options or {}
	# @opts.suit = options.suit or 'hearts'
	# @opts.value = options.suit or 'ace'
	card = 
		suit: @opts.suit
		value: @opts.value
		color: () ->
			console.log( @suit )
			if @suit == 'hearts' or @suit == 'diamonds'
				return 'red'
			else
				return 'black'
	return card

module.exports = Card