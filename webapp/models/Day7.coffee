Day = require './abstract/Day.coffee'

class Day7 extends Day
	puzzle1Completed: true
	puzzle2Completed: true
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
		shiftGatePattern = /^(\w+) (LSHIFT|RSHIFT) (\w+) -> (\w+)$/i
		notGatePattern = /^NOT (\w+) -> (\w+)$/i

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
			else if shiftGatePattern.test instruction
				matches = shiftGatePattern.exec instruction
				sourceWire = matches[1]
				operator = matches[2]
				shiftAmount = parseInt matches[3]
				targetWire = matches[4]

				checkSourceWire sourceWire

				wireFunctions[targetWire] = do (sourceWire, operator, shiftAmount, targetWire) -> ->
					result = if operator is 'LSHIFT' then wireFunctions[sourceWire]() << shiftAmount else wireFunctions[sourceWire]() >> shiftAmount
					wireFunctions[targetWire] = () ->
						result
					result
			else if notGatePattern.test instruction
				matches = notGatePattern.exec instruction
				sourceWire = matches[1]
				targetWire = matches[2]

				checkSourceWire sourceWire

				wireFunctions[targetWire] = do (sourceWire, targetWire) -> ->
					result = ~ wireFunctions[sourceWire]() & 65535
					wireFunctions[targetWire] = () ->
						result
					result

		wireFunctions[inputs.wire]()


	getPuzzle1Code: ->
		code = [
			@runPuzzle1.toString()
		]

		code.join '\n'

	getPuzzle2Inputs: () ->
		inputs = @getPuzzle1Inputs()
		inputs.push
			label: 'Wire to Override'
			type: 'text'
			name: 'override_wire'
		inputs

	runPuzzle2: (inputs) ->
		puzzle2Inputs =
			instructions: inputs.instructions
			wire: inputs.wire

		result = @runPuzzle1 puzzle2Inputs
		inputs.instructions += '\n' + result + ' -> ' + inputs.override_wire

		@runPuzzle1 inputs

	getPuzzle2Code: () ->
		code = [
			@runPuzzle2.toString()
		]

		code.join '\n'

module.exports =
	name: 'Day7'
	instance: Day7