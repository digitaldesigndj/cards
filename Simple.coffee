'use strict'

Poker = require( './Poker' )

JacksOrBetter = new Poker()

Simple = ( options ) ->
	@opts = options or {}
	return @

Simple::play = ( hand ) ->
	score = JacksOrBetter.score( hand, 5 )
	# console.log( score )

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

Simple::step1 = ( hand ) ->
	console.log hand
	return 'whatss'

# sortNumber = ( a, b ) ->
# 	return a - b

module.exports = Simple
