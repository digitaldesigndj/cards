'use strict'

Poker = require( './Poker' )

JacksOrBetter = new Poker()

Optimal = ( options ) ->
	@opts = options or {}
	return @

Optimal::play = ( hand ) ->
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

	high = getHighCards( hand )
	flush = getFlushCards( hand )
	royalFlushCards = []
	straight = getStraightCards( hand )

	# Optimal Strategy 

	# 1 Dealt royal flush (800.0000)
	if score.status is 'royalflush'
		return hand

	# 2 Dealt straight flush (50.0000)
	if score.status is 'straightflush'
		return hand

	# 3 Dealt four of a kind (25.0000)
	if score.status is '4kind'
		return hand

	# 4 4 to a royal flush (18.3617)
	if flush.cards.length >= 3
		if high.cards.length >= 3
			high.cards.map( ( cardindex ) ->
				if flush.cards.indexOf( cardindex ) isnt -1
					royalFlushCards.push( cardindex )
			)
			if royalFlushCards.length is 4
				hand.cards.map( ( card, i ) ->
					if royalFlushCards.indexOf( card ) is -1
						hand.replace( i )
				)
				return hand

	# 5 Dealt full house (9.0000)
	if score.status is 'fullhouse'
		return hand

	# 6 Dealt flush (6.0000)
	if score.status is 'flush'
		return hand

	# 7 3 of a kind (4.3025)
	if score.status is '3kind'
		return holdDupes( hand, 3 )

	# 8 Dealt straight (4.0000)
	if score.status is 'straight'
		return hand

	# 9 4 to a straight flush (3.5319)


	# 10 Two pair (2.59574)
	if score.status is '2pair'
		hand.cards.map( ( card, i ) ->
			occurance = 0
			hand.cards.map( ( compare_card ) ->
				if card.rawValue is compare_card.rawValue
					occurance++
			)
			if occurance is 1
				hand.replace( i )
		)
		return hand

	# 11 High pair (1.5365)
	if score.status is 'jacksbetter'
		return holdDupes( hand, 2 )

	# 12 3 to a royal flush (1.2868) A
	# Exception 'A' not implemented
	if royalFlushCards.length >= 3
		hand.cards.map( ( card, i ) ->
			if royalFlushCards.indexOf( card ) is -1
				hand.replace( i )
		)
		return hand

	# 13 4 to a flush (1.2766)
	if flush.cards.length >= 4
		hand.cards.map( ( card, i ) ->
			if flush.cards.indexOf( i ) is -1
				hand.replace( i )
		)
		return hand

	# 14 Unsuited TJQK(0.8723)
	

	# 15 Low pair (0.8237)
	if score.status is 'lowpair'
		return holdDupes( hand, 2 )

	# 16 4 to an outside straight with 0-2 high cards(0.6809)
	# 17 3 to a straight flush (type 1) (0.6207 to 0.6429)
	# 18 Suited QJ (0.6004)B
	# 19 4 to an inside straight, 4 high cards (0.5957)
	# 20 Suited KQ or KJ (0.5821)
	# 21 Suited AK, AQ, or AJ (0.5678)
	# 22 4 to an inside straight, 3 high cards (0.5319)
	# 23 3 to a straight flush (type 2) (0.5227 to 0.5097)C
	# 24 Unsuited JQK (0.5005)
	# 25 Unsuited JQ (0.4980)
	# 26 Suited TJ (0.4968) D
	# 27 2 unsuited high cards king highest (0.4862)
	# 28 Suited TQ (0.4825) E
	# 29 2 unsuited high cards ace highest (0.4743)
	# 30 J only (0.4713)
	# 31 Suited TK (0.4682) F
	# 32 Q only (0.4681)
	# 33 K only (0.4649)
	# 34 A only (0.4640)
	# 35 3 to a straight flush (type 3) (0.4431)
	# 36 Garbage, discard everything (0.3597)


	# Hands That Are Never Played

	# Suited 10 and ace (keep the ace only)
	# 3 unsuited high cards, ace highest (keep the lowest two high cards)
	# 4 to an inside straight, 2 high cards (keep the two high cards)
	# 4 to an inside straight, 1 high card (keep the single high card)
	# 4 to an inside straight, 0 high cards (discard everything)


	# OLD OLD OLD

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

# Optimal::step1 = ( hand ) ->
# 	console.log hand
# 	return 'whatss'

sortNumber = ( a, b ) ->
	return a - b

getFlushCards = ( hand ) ->
	flush =
		cards: []
		suit: ''
	[0..3].map( ( v, i ) ->
		count = 0
		cards = []
		hand.cards.map( ( card, idx ) ->
			if card.rawSuit == v
				count++
				cards.push( idx )
			return
		)
		if cards.length >= 3
			flush.cards = cards
			flush.suit = v
	)
	return flush

getHighCards = ( hand ) ->
	high =
		cards: []
	highCards = [0,9,10,11,12]
	hand.cards.map( ( card, i ) ->
		highCards.map( ( val ) ->
			if card.rawValue is val
				high.cards.push( i )
		)
	)
	return high

holdDupes = ( hand, length ) ->
	[0..12].map( ( v, i ) ->
		count = 0
		holds = []
		hand.cards.map( ( card, idx ) ->
			if card.rawValue == v
				holds.push( idx )
			return
		)
		if holds.length is length
			hand.cards.map( ( card, index ) ->
				if card.rawValue isnt v
					hand.replace( index )
			)
	)
	return hand

getStraightCards = ( hand ) ->
	smallStraights = []
	straights = [
		[0,9,10,11,12]
		[1..5]
		[2..6]
		[3..7]
		[4..8]
		[5..9]
		[6..10]
		[7..11]
		[8..12]
	]

	# [0,9,10,11,12]
	# [9,10,11,12]
	# [0,10,11,12]
	# [0,9,11,12]
	# [0,9,10,12]
	# [0,9,10,11]

	insideStraightQuads = [
		[1..4]
		[2..5]
		[3..6]
		[4..7]
		[5..8]
		[6..9]
		[7..10]
		[8..11]
	]
	# console.log( straights )
	# straights.map( ( array, i ) ->
	# 	array.map( ( v, idx ) ->
	# 		small = array
	# 		smallstraights.push( small.splice( idx, 1 ) )
	# 	)
	# )
	# console.log( straights, smallstraights )

module.exports = Optimal
