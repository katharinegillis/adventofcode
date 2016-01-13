Day = require './abstract/Day.coffee'

class Day11 extends Day
	puzzle1Completed: true
	puzzle2Completed: true
	name: 'Corporate Policy'

	getPuzzle1Inputs: () ->
		[
			{label: 'Old Password', type: 'text', name: 'old_password'}
		]

	runPuzzle1: (inputs) ->
		password = inputs.old_password

		valid = false
		increasingStraightPattern = /(?:abc|bcd|cde|def|efg|fgh|ghi|hij|ijk|jkl|klm|lmn|mno|nop|opq|pqr|qrs|rst|stu|tuv|uvw|vwx|wxy|xyz)/i;
		invalidLettersPattern = /[iol]/i
		hasPairsPattern = /(\w)\1.*(\w)\2/i
		hasSamePairsPattern = /(\w)\1.*\1\1/i
		while not valid
			password = @incrementString password

			valid = true if increasingStraightPattern.test(password) and not invalidLettersPattern.test(password) and hasPairsPattern.test(password) and not hasSamePairsPattern.test(password)

		password

	getPuzzle1Code: () ->
		code = [
			@incrementString.toString()
			@runPuzzle1.toString()
		]

		code.join '\n'

	getPuzzle2Inputs: () ->
		@getPuzzle1Inputs()

	runPuzzle2: (inputs) ->
		password = @runPuzzle1 inputs
		@runPuzzle1 old_password: password

	getPuzzle2Code: () ->
		code = [
			@incrementString.toString()
			@runPuzzle1.toString()
			@runPuzzle2.toString()
		]

		code.join '\n'

	incrementString: (string) ->
		reverseCharArray = string.split('').reverse()

		addA = false
		for char, i in reverseCharArray
			if char isnt 'z'
				reverseCharArray[i] = String.fromCharCode char.charCodeAt(0) + 1
				break
			else
				reverseCharArray[i] = 'a'
				addA = i is (reverseCharArray.length - 1)

		newString = reverseCharArray.reverse().join ''
		newString = 'a' + newString if addA
		newString

module.exports =
	name: 'Day11'
	instance: Day11