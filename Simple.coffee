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


	# royal flush player
	# if 3+ royals
	# if royals flush
	# Do it

	# Simple Strategy 
	
	# Four of a kind, straight flush, royal flush
	if score.status is 'royalflush'
		return hand
	if score.status is 'straightflush'
		return hand
	if score.status is '4kind'
		return hand

	# 4 to a royal flush
	## Check for high cards
	high = getHighCards( hand )
	## Check for a flush
	flush = getFlushCards( hand )
	# if flush isnt false
	# 	console.log( 'FLUSH', flush )
	royalFlushCards = []

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
				# console.log( hand )
				# console.log( royalFlushCards, royalFlushCards.length )
				# console.log( 'SomeROYAL', high.cards, flush.cards )
				# console.log( hand.cards )
	# console.log( fourToAFlushSuit )
	# if fourToAFlushSuit isnt ''
	# 	if highCardsInHand.length >= 4
	# if threeToAFlushSuit isnt '' or fourToAFlushSuit isnt ''
	# if true
	# 	if highCardsInHand.length >= 3
	# 		cardsToRoyalFlush = 0
	# 		hand.cards.map( ( card, i ) ->
	# 			return
	# 		)


		# four2flush = values.sort( sortNumber )
		# if four2flush.shift() is 0
		# # if acelow
		# 		[
		# 			[0,9,10,11]
		# 			[0,9,10,12]
		# 			[0,9,11,12]
		# 			[0,10,11,12]
		# 		].map( ( v, i ) ->
		# 			if JSON.stringify( four2flush ) is JSON.stringify( v )
		# 				# hand.cards.map( ( card, idx ) ->
		# 				# 	# if card.rawValue isnt in 
		# 				# 	found = false
		# 				# 	if [0,9,10,11,12].find( ( element ) ->
		# 				# 		if card.rawValue is element
		# 				# 			found = true
		# 				# 	)
		# 				# )
		# 				return hand
		# 		)
		# else
		# 	if JSON.stringify( four2flush ) is JSON.stringify( [9,10,11,12] )
		# 		return hand


	# Three of a kind, straight, flush, full house
	if score.status is '3kind'
		return holdPairs( hand, values, 3 )

	if score.status is 'straight'
		return hand
	if score.status is 'flush'
		return hand
	if score.status is 'fullhouse'
		return hand

	# 4 to a straight flush
	# if fourToAFlushSuit isnt ''
	# 	# DO THINGS LIKE 
	# 	## Look for straight, discard outlier
	# 	[0..3].map( ( v, i ) ->
	# 		count = 0
	# 		suits.map( ( val, idx ) ->
	# 			if val == v
	# 				count++
	# 			return
	# 		)
	# 		if count is 4
	# 			## Look for straight, discard outlier
	# 			return hand
	# 	)

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
		return holdPairs( hand, values, 2 )

	# 3 to a royal flush
	if royalFlushCards.length >= 3
		hand.cards.map( ( card, i ) ->
			if royalFlushCards.indexOf( card ) is -1
				hand.replace( i )
		)
		return hand

	# 4 to a flush
	# completion
	# if fourToAFlushSuit isnt ''
	# 	hand.cards.map( ( card, i ) ->
	# 		if card.rawSuit isnt fourToAFlushSuit
	# 			hand.replace( i )
	# 	)
	# 	return hand

	# Low pair
	if score.status is 'lowpair'
		return holdPairs( hand, values, 2 )

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

# Simple::step1 = ( hand ) ->
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

holdPairs = ( hand, values, length ) ->
	[0..12].map( ( v, i ) ->
		count = 0
		holds = []
		values.map( ( val, idx ) ->
			if val == v
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

module.exports = Simple
