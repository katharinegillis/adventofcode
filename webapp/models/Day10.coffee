Day = require './abstract/Day.coffee'

class Day10 extends Day
	puzzle1Completed: true
	puzzle2Completed: true
	name: 'Elves Look, Elves Say'

	getPuzzle1Inputs: () ->
		[
			{label: 'String', type: 'text', name: 'string'}
		]

	runPuzzle1: (inputs) ->
		string = inputs.string

		for i in [1..40]
			newString = ''
			currChar = ''
			count = 0
			for char in string
				if currChar isnt char
					if currChar isnt ''
						newString += count + '' +  currChar

					currChar = char
					count = 1
				else
					count++

			newString += count + '' + currChar if count > 0
			string = newString

		newString.length

	getPuzzle1Code: () ->
		code = [
			@runPuzzle1.toString()
		]

		code.join '\n'

	getPuzzle2Inputs: () ->
		@getPuzzle1Inputs()

	runPuzzle2: (inputs) ->
		string = inputs.string

		for i in [1..50]
			newString = ''
			currChar = ''
			count = 0
			for char in string
				if currChar isnt char
					if currChar isnt ''
						newString += count + '' +  currChar

					currChar = char
					count = 1
				else
					count++

			newString += count + '' + currChar if count > 0
			string = newString

		newString.length

	getPuzzle2Code: () ->
		code = [
			@runPuzzle2.toString()
		]

		code.join '\n'

module.exports =
	name: 'Day10'
	instance: Day10