'use strict'

Poker = require( './Poker' )
Util = require( './util' )

JacksOrBetter = new Poker()

Simple = ( options ) ->
	@opts = options or {}
	return @

Simple::play = ( hand ) ->
	score = JacksOrBetter.score( hand, 5 )

	# Simple Strategy 

	# Four of a kind, straight flush, royal flush
	if score.status is 'royalflush'
		return hand
	if score.status is 'straightflush'
		return hand
	if score.status is '4kind'
		return hand

	# 4 to a royal flush
	high = JacksOrBetter.getHighCards( hand )
	flush = JacksOrBetter.getFlushCards( hand )
	royalFlush = JacksOrBetter.getRoyalFlushCards( hand, high, flush )
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
		return Util.holdDupes( hand, 3 )

	if score.status is 'straight'
		return hand
	if score.status is 'flush'
		return hand
	if score.status is 'fullhouse'
		return hand

	# 4 to a straight flush
	straight = JacksOrBetter.getStraightOutlierCard( hand, 'all' )
	if flush.cards.length >= 4
		if straight.length isnt 0
			console.log( flush.suit );
			# once = false
			console.log 'flush straight oulier: ' + straight
			hand.cards.map ( card, i ) ->
				if card.rawValue is straight
					if card.rawSuit is flush.suit
						# console.log( 'FLUSH no match ' )
					else
						# console.log( 'FLUSH - MATCH ' )
						hand.replace( i )
			return hand

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
		return Util.holdDupes( hand, 2 )

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
		return Util.holdDupes( hand, 2 )

	# 4 to an outside straight
	outsideStraight = JacksOrBetter.getStraightOutlierCard( hand, 'outside' )
	if outsideStraight.length isnt 0
		# once = false
		# console.log 'ouside straight oulier: ' + outsideStraight
		hand.cards.map ( card, i ) ->
			if card.rawValue is outsideStraight
				hand.replace( i )
		return hand

	# 2 suited high cards
	if flush.cards.length >= 2
		if high.cards.length >= 2
			# console.log( 'Things', high.cards, flush.suit )
			suitedHigh = []
			high.cards.map ( card_idx ) ->
				if hand.cards[card_idx].rawSuit is flush.suit
					suitedHigh.push( card_idx )
				return
			if suitedHigh.length >= 2
				# console.log( '2 suited high cards', suitedHigh )
				hand.keepArray( suitedHigh )
				return hand

	# 3 to a straight flush

	# 2 unsuited high cards (if more than 2 then pick the lowest 2)
	if high.cards.length >= 2
		if high.cards.length == 2
			# console.log  " CARDSSSS " + high.cards
			hand.keepArray( high.cards )
			return hand
		else
			false

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
