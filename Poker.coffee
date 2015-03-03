'use strict'

Poker = ( options ) ->
	@opts = options or {}
	return @

Poker::score = ( hand, bet ) ->
	self = @
	bet = bet || 5

	# Doubles
	# rawsuit
	values = []
	hand.cards.map( ( card, i ) ->
		values.push( card.rawValue )
	)

	values.sort( sortNumber )

	suits = []
	hand.cards.map( ( card, i ) ->
		suits.push( card.rawSuit )
	)

	# console.log suits, suits.sort( sortNumber )

	score = 
		status: 'ulose'
		win: 0

	straights = [
		[1..5]
		[2..6]
		[3..7]
		[4..8]
		[5..9]
		[6..10]
		[7..11]
		[8..12]
	]
	royal_straight = [0,9,10,11,12]
	# pair_count = 0
	# triple_count = 0
	# jacks_or_better = false
	# console.log( values )
	royal = false
	straight = false
	flush = false
	pair1 = false
	pair2 = false
	triple = false
	quad = false
	jacksorbetter = false

	# console.log( values )

	# royal straigt checker
	if JSON.stringify( values ) is JSON.stringify( royal_straight )
		royal = true

	# straight checker
	straights.map( ( v, i ) ->
		if JSON.stringify( values ) is JSON.stringify( v )
			straight = true
	)

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

	# flush checker
	[0..3].map( ( v, i ) ->
		count = 0
		suits.map( ( val, idx ) ->
			if val == v
				count++
			return
		)
		if count is 5
			flush = true
	)

	# Score Reporter
	if royal and flush
		score.status = 'royalflush'
		score.win = bet * 800
		return score
	else if  ( flush or royal ) and straight
		score.status = 'straightflush'
		score.win = bet * 50
		return score
	else if quad
		score.status = '4kind'
		score.win = bet * 25
		return score
	else if triple and pair1
		score.status = 'fullhouse'
		score.win = bet * 9
		return score
	else if flush or royal
		score.status = 'flush'
		score.win = bet * 6
		return score
	else if straight
		score.status = 'straight'
		score.win = bet * 4
		return score
	else if triple
		score.status = '3kind'
		score.win = bet * 3
		return score
	else if pair1 and pair2
		score.status = '2pair'
		score.win = bet * 2
		return score
	else if jacksorbetter
		score.status = 'jacksbetter'
		score.win = bet * 1
		return score
	else if pair1
		score.status = 'lowpair'
		score.win = 0
		return score
	else
		return score

# Royal flush	800
# Straight flush	50
# Four of a kind	25
# Full house	9
# Flush	6
# Straight	4
# Three of a kind	3
# Two pair	2
# Pair	1
# Nothing	0


Poker::thing = ( ) ->
	return 'string'

sortNumber = ( a, b ) ->
	return a - b

module.exports = Poker
