module.exports.sortNumber = ( a, b ) ->
	return a - b

module.exports.holdDupes = ( hand, length ) ->
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

# 30, 32, 33, 34
holdSingle = ( hand, high, hold ) ->
	high.cards.map( ( card, i ) ->
		letter = hand.cards[i].valueLetter()
		if letter is hold
			hand.keepOne( card )
	)
	return
