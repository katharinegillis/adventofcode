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
		wireValues = {}
		wireFunctions = {}

		wireAssignmentPattern = /^(\w+) -> (\w+)$/i
		andOrGatePattern = /^(\w+) (AND|OR) (\w+) -> ([a-z]+)$/i
		shiftGatePattern = /^(\w+) (RSHIFT|LSHIFT) (\d+) -> (\w+)$/i
		notGatePattern = /^NOT (\w+) -> (\w+)$/i

		getWireValue = (wire) ->
			return wireValues[wire] if wireValues[wire]?

			console.log wire
			console.log wireFunctions[wire]
			wireFunctions[wire]()

		checkSourceWire = (wire) ->
			if not isNaN parseInt(wire) and not wireValues[wire]?
				wireValues[wire] = wire

		for instruction in instructions
			if wireAssignmentPattern.test instruction
				matches = wireAssignmentPattern.exec instruction
				sourceWire = matches[1]
				targetWire = matches[2]

				checkSourceWire sourceWire

				wireFunctions[targetWire] = () ->
					getWireValue sourceWire
			else if andOrGatePattern.test instruction
				matches = andOrGatePattern.exec instruction
				sourceWireA = matches[1]
				operator = matches[2]
				sourceWireB = matches[3]
				targetWire = matches[4]

				checkSourceWire sourceWireA
				checkSourceWire sourceWireB

				switch operator
					when 'AND'
						wireFunctions[targetWire] = () ->
							getWireValue(sourceWireA) & getWireValue(sourceWireB)
					when 'OR'
						wireFunctions[targetWire] = () ->
							getWireValue(sourceWireA) | getWireValue(sourceWireB)
			else if shiftGatePattern.test instruction
				matches = shiftGatePattern.exec instruction
				sourceWire = matches[1]
				operator = matches[2]
				shiftAmount = parseInt matches[3]
				targetWire = matches[4]

				checkSourceWire sourceWire

				switch operator
					when 'RSHIFT'
						wireFunctions[targetWire] = () ->
							getWireValue(sourceWire) >> shiftAmount
					when 'LSHIFT'
						wireFunctions[targetWire] = () ->
							getWireValue(sourceWire) << shiftAmount
			else if notGatePattern.test instruction
				matches = notGatePattern.exec instruction
				sourceWire = matches[1]
				targetWire = matches[2]

				checkSourceWire sourceWire

				wireFunctions[targetWire] = () ->
					~ getWireValue(sourceWire)

		console.log wireFunctions

		wireFunctions[inputs.wire]()

	getPuzzle1Code: ->
		code = [
			@runPuzzle1.toString()
		]

		code.join '\n'

module.exports =
	name: 'Day7'
	instance: Day7