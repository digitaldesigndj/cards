'use strict'

Hand = ( options ) ->
	@opts = options or {}
	@opts.size = options.size or 0
	@cards = []
	while @cards.length < @opts.size
		@cards.push( @opts.deck.draw() )
	# console.log( @opts.deck.cards.length )
	return @

Hand::discard = ( index ) ->
	idx = index or 0
	@cards.splice( idx, 1 )
	return

Hand::draw = ( ) ->
	@cards.push( @opts.deck.draw() )
	return

Hand::replace = ( index ) ->
	idx = index or 0
	@discard( idx )
	@draw()
	return

module.exports = Hand