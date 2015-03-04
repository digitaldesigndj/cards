'use strict'

Poker = require( './Poker' )

JacksOrBetter = new Poker()

Simple = ( options ) ->
	@opts = options or {}
	return @

Simple::play = ( hand ) ->
	score = JacksOrBetter.score( hand, 5 )
	# console.log( score )

	values = []
	hand.cards.map( ( card, i ) ->
		values.push( card.rawValue )
	)
	values.sort( sortNumber )

	suits = []
	hand.cards.map( ( card, i ) ->
		suits.push( card.rawSuit )
	)


	# score.status = 'royalflush'
	# score.status = 'straightflush'
	# score.status = '4kind'
	# score.status = 'fullhouse'
	# score.status = 'flush'
	# score.status = 'straight'
	# score.status = '3kind'
	# score.status = '2pair'
	# score.status = 'jacksbetter'
	# score.status = 'lowpair'


	# Simple Strategy 
	
	# Four of a kind, straight flush, royal flush
	if score.status is 'royalflush'
		return hand
	else if score.status is 'straightflush'
		return hand
	else if score.status is '4kind'
		return hand

	# 4 to a royal flush
	four2flush = values
	if four2flush.shift() is 0
	# if acelow
			[
				[0,9,10,11]
				[0,9,10,12]
				[0,9,11,12]
				[0,10,11,12]
			].map( ( v, i ) ->
				if JSON.stringify( four2flush ) is JSON.stringify( v )
					return hand
			)
	else
		if JSON.stringify( four2flush ) is JSON.stringify( [9,10,11,12] )
			return hand


	# Three of a kind, straight, flush, full house

	if score.status is '3kind'
		return hand
	else if score.status is 'straight'
		return hand
	else if score.status is 'flush'
		return hand
	else if score.status is 'fullhouse'
		return hand

	# 4 to a straight flush

	# Two pair

	if score.status is '2pair'
		return hand

	# High pair
	if score.status is 'jacksbetter'
		return hand

	# 3 to a royal flush

	# 4 to a flush
	[0..3].map( ( v, i ) ->
		count = 0
		suits.map( ( val, idx ) ->
			if val == v
				count++
			return
		)
		if count is 4
			return hand
	)

	# Low pair
	if score.status is 'lowpair'
		return hand

	# 4 to an outside straight

	# 2 suited high cards

	# 3 to a straight flush

	# 2 unsuited high cards (if more than 2 then pick the lowest 2)

	# Suited 10/J, 10/Q, or 10/K

	# One high card

	# Discard everything
	# console.log( 'lose everything' )
	hand.replace()
	hand.replace()
	hand.replace()
	hand.replace()
	hand.replace()

	return hand

# Simple::step1 = ( hand ) ->
# 	console.log hand
# 	return 'whatss'

sortNumber = ( a, b ) ->
	return a - b

module.exports = Simple
