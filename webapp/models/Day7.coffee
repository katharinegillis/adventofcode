Day = require './abstract/Day.coffee'

class Day7 extends Day
	puzzle1Completed: false
	puzzle2Completed: false
	name: 'Some Assembly Required'

	getPuzzle1Inputs: ->
		[
			{label: 'Instructions', type: 'textarea', name: 'instructions'},
			{label: 'Wire', type: 'text', name: 'wire'}
		]

	runPuzzle1: (inputs) ->
		instructions = inputs.instructions.split '\n'
		wireFunctions = {}

		wireAssignmentPattern = /^(\w+) -> (\w+)$/i
		andOrGatePattern = /^(\w+) (AND|OR) (\w+) -> (\w+)$/i

		checkSourceWire = (sourceWire) ->
			if /^\d+$/.test(sourceWire)
				signal = parseInt sourceWire
				wireFunctions[sourceWire] = do (signal) -> ->
					signal

		for instruction in instructions
			if wireAssignmentPattern.test instruction
				matches = wireAssignmentPattern.exec instruction
				sourceWire = matches[1]
				targetWire = matches[2]

				checkSourceWire sourceWire

				wireFunctions[targetWire] = do (sourceWire, targetWire) -> ->
					result = wireFunctions[sourceWire]()
					wireFunctions[targetWire] = () ->
						result
					result
			else if andOrGatePattern.test instruction
				matches = andOrGatePattern.exec instruction
				sourceWireA = matches[1]
				operator = matches[2]
				sourceWireB = matches[3]
				targetWire = matches[4]

				checkSourceWire sourceWireA
				checkSourceWire sourceWireB

				wireFunctions[targetWire] = do (sourceWireA, sourceWireB, targetWire, operator) -> ->
					result = if operator is 'AND' then wireFunctions[sourceWireA]() & wireFunctions[sourceWireB]() else wireFunctions[sourceWireA]() | wireFunctions[sourceWireB]()
					wireFunctions[targetWire] = () ->
						result
					result

		wireFunctions[inputs.wire]()


	getPuzzle1Code: ->
		code = [
			@runPuzzle1.toString()
		]

		code.join '\n'

module.exports =
	name: 'Day7'
	instance: Day7