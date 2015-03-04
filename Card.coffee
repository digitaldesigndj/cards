'use strict'

Card = ( options ) ->
	@opts = options or {}
	@suit = options.suit or 0
	@value = options.value or 0
	suitNames = [
		'hearts'
		'diamonds'
		'clubs'
		'spades'
	]
	suitUnicode = [
		'\u2660'
		'\u2665'
		'\u2666'
		'\u2663'
	]
	suitUnicodeOutline = [
		'\u2661'
		'\u2662'
		'\u2667'
		'\u2664'
	]
	valueNames = [
		'ace'
		'two'
		'three'
		'four'
		'five'
		'six'
		'seven'
		'eight'
		'nine'
		'ten'
		'jack'
		'queen'
		'king'
	]
	valueLetters = [
		'A'
		'2'
		'3'
		'4'
		'5'
		'6'
		'7'
		'8'
		'9'
		'T'
		'J'
		'Q'
		'K'
	]
	card = 
		rawSuit: @suit
		rawValue: @value
		unicode: () ->
			return suitUnicode[@rawSuit]
		unicodeSuit: () ->
			return suitUnicodeOutline[@rawSuit]
		suit: () ->
			return suitNames[@rawSuit]
		value: () ->
			return valueNames[@rawValue]
		valueLetter: () ->
			return valueLetters[@rawValue]
		color: () ->
			# console.log( @rawSuit )
			if @suit() == 'hearts' or @suit() == 'diamonds'
				return 'red'
			else
				return 'black'
	return card

module.exports = Card