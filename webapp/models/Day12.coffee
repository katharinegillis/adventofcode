Day = require './abstract/Day.coffee'

class Day12 extends Day
	puzzle1Completed: true
	puzzle2Completed: true
	name: 'JSAbacusFramework.io'

	getPuzzle1Inputs: () ->
		[
			{label: 'Document', type: 'textarea', name: 'document'}
		]

	runPuzzle1: (inputs) ->
		document = inputs.document

		numberPattern = /(-*\d+)/g
		matches = document.match numberPattern
		sum = 0
		for match in matches
			sum += parseInt match

		sum

	getPuzzle1Code: () ->
		code = [
			@runPuzzle1.toString()
		]

		code.join '\n'

	getPuzzle2Inputs: () ->
		@getPuzzle1Inputs()

	runPuzzle2: (inputs) ->
		document = JSON.parse inputs.document

		getValue = (obj) ->
			if Array.isArray(obj)
				sum = 0
				for element in obj
					sum += getValue element
				return sum
			else if typeof obj is 'object'
				sum = 0
				for key, value of obj
					if value is 'red'
						sum = 0
						break

					sum += getValue value
				return sum
			else if typeof obj is 'number'
				return obj
			else
				return 0

		getValue document

	getPuzzle2Code: () ->
		code = [
			@runPuzzle2.toString()
		]

		code.join '\n'

module.exports =
	name: 'Day12'
	instance: Day12