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

Hand::draw = ( int ) ->
	i = int or 1
	@cards.push( @opts.deck.draw() ) for [1..i] if i
	return

Hand::replace = ( index ) ->
	idx = index or 0
	@discard( idx )
	@draw()
	return

Hand::keepArray = ( array ) ->
	draw = 0
	self = @
	[0..4].reverse().map ( i ) ->
		if array.indexOf( i ) is -1
			self.discard( i )
			draw++
	@draw( draw )

Hand::keepOne = ( index ) ->
	idx = index or 0
	[0..4].map( ( v ) ->
		if idx != v
			@discard( idx )
			@draw()
	)
	return

module.exports = Hand