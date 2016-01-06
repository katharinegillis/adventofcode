Day = require './abstract/Day.coffee'

class Day8 extends Day
	puzzle1Completed: true
	puzzle2Completed: true
	name: 'Matchsticks'

	getPuzzle1Inputs: () ->
		[
			{label: 'Strings', type: 'textarea', name: 'strings'}
		]

	runPuzzle1: (inputs) ->
		strings = inputs.strings.split '\n'
		diff = 0;

		for str in strings
			len = new Function('return ' + str + '.length')
			diff += str.length - len()
		diff

	getPuzzle1Code: () ->
		code = [
			@runPuzzle1.toString()
		]

		code.join '\n'

	getPuzzle2Inputs: () ->
		@getPuzzle1Inputs()

	runPuzzle2: (inputs) ->
		strings = inputs.strings.split '\n'
		diff = 0

		for str in strings
			newStr = '"' + str.replace(/\\/g, '\\\\').replace(/"/g, '\\"') + '"'
			console.log newStr
			diff += newStr.length - str.length

		diff

	getPuzzle2Code: () ->
		code = [
			@runPuzzle2.toString()
		]

		code.join '\n'

module.exports =
	name: 'Day8',
	instance: Day8