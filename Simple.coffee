'use strict'

Poker = require( './Poker' )
util = require( './util' )

JacksOrBetter = new Poker()

Simple = ( options ) ->
	@opts = options or {}
	return @

Simple::play = ( hand ) ->
	score = JacksOrBetter.score( hand, 5 )
	high = JacksOrBetter.getHighCards( hand )
	flush = JacksOrBetter.getFlushCards( hand )
	royalFlush = JacksOrBetter.getRoyalFlushCards( hand, high, flush )

	# Simple Strategy 

	# Four of a kind, straight flush, royal flush
	if score.status is 'royalflush'
		return hand
	if score.status is 'straightflush'
		return hand
	if score.status is '4kind'
		return hand

	# 4 to a royal flush
	if flush.cards.length >= 3
		if high.cards.length >= 3
			if royalFlush.cards.length is 4
				hand.cards.map( ( card, i ) ->
					if royalFlush.cards.indexOf( card ) is -1
						hand.replace( i )
				)
				return hand

	# Three of a kind, straight, flush, full house
	if score.status is '3kind'
		return util.holdDupes( hand, 3 )

	if score.status is 'straight'
		return hand
	if score.status is 'flush'
		return hand
	if score.status is 'fullhouse'
		return hand

	# 4 to a straight flush
	# if flush.cards.length >= 4
	# 	# DO THINGS LIKE 
	# 	## Look for straight, discard outlier

	# Two pair
	if score.status is '2pair'
		hand.cards.map( ( card, i ) ->
			occurance = 0
			hand.cards.map( ( compare_card ) ->
				if card.rawValue is compare_card.rawValue
					occurance++
			)
			if occurance is 1
				# console.log( hand.cards, i )
				hand.replace( i )
				# console.log( hand.cards )
		)
		return hand

	# High pair
	if score.status is 'jacksbetter'
		return util.holdDupes( hand, 2 )

	# 3 to a royal flush
	if royalFlush.cards.length >= 3
		hand.cards.map( ( card, i ) ->
			if royalFlush.cards.indexOf( card ) is -1
				hand.replace( i )
		)
		return hand

	# 4 to a flush
	if flush.cards.length >= 4
		hand.cards.map( ( card, i ) ->
			if flush.cards.indexOf( i ) is -1
				hand.replace( i )
		)
		return hand

	# Low pair
	if score.status is 'lowpair'
		return util.holdDupes( hand, 2 )

	# 4 to an outside straight

	# 2 suited high cards

	# 3 to a straight flush

	# 2 unsuited high cards (if more than 2 then pick the lowest 2)

	# Suited 10/J, 10/Q, or 10/K

	# One high card
	# (Holds All High Cards)
	highcard = false
	discards = []
	hand.cards.map( ( card, i ) ->
		[0,9,10,11,12].map( ( val, idx ) ->
			if card.rawValue is val
				highcard = true
			else
				discards.push( idx )
		)
	)
	if discards.length > 0
		discards.map( ( discard ) ->
			hand.replace( discard )
		)
		return hand

	# Discard everything
	if highcard is false
		console.log( 'lose everything' )
		hand.replace(0)
		hand.replace(1)
		hand.replace(2)
		hand.replace(3)
		hand.replace(4)
	return hand

module.exports = Simple
