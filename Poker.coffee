'use strict'

Poker = ( options ) ->
	@opts = options or {}
	return @

Poker::score = ( hand ) ->
	self = @

	# Doubles
	# rawsuit
	values = []
	hand.cards.map( ( card, i ) ->
		values.push( card.rawValue )
	)

	suits = []
	hand.cards.map( ( card, i ) ->
		suits.push( card.suit() )
	)

	# console.log( values )
	score = 'ulose'
	pair1 = false
	pair2 = false
	triple = false
	quad = false
	jacksorbetter = false

	# console.log( values )

	# dupe checker, pair, 2pair, 3kind, 4kind, fullhouse
	[0..12].map( ( v, i ) ->
		# console.log( v )
		count = 0
		values.map( ( val, idx ) ->
			if val == v
				count++
			return
		)
		if count is 2
			if v >= 9
				jacksorbetter = true
			if pair1 is true
				pair2 = true
			else
				pair1 = true
		if count is 3
			triple = true
		if count is 4
			quad = true
	)
	if quad
		score = '4kind'
		return score
	else if triple and pair1
		score = 'fullhouse'
		return score
	else if triple
		score = '3kind'
		return score
	else if pair1 and pair2
		score = '2pair'
		return score
	else if jacksorbetter
		score = 'jacksbetter'
		return score
	else if pair1
		score = 'lowpair'
		return score
	else
		return score

Poker::thing = ( ) ->
	return 'string'

module.exports = Poker
