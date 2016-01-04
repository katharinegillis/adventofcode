Day = require './abstract/Day.coffee'

class Day6 extends Day
	puzzle1Completed: true
	puzzle2Completed: true
	name: 'Probably a Fire Hazard'

	getPuzzle1Inputs: ->
		[
			{label: 'Instructions', type: 'textarea', name: 'instructions'}
		]

	runPuzzle1: (inputs) ->
		instructions = inputs.instructions.split '\n'

		turnOn = (lights, currX, currY) ->
			lights[currX ][currY] = true

		turnOff = (lights, currX, currY) ->
			lights[currX][currY] = false

		toggle = (lights, currX, currY) ->
			if lights[currX][currY]
				turnOff lights, currX, currY
			else
				turnOn lights, currX, currY

		lights = []
		for i in [0...1000]
			lights[i] = []
			for j in [0...1000]
				lights[i][j] = false

		pattern = /^(turn on|toggle|turn off) (\d+),(\d+) through (\d+),(\d+)$/
		for instruction in instructions
			matches = pattern.exec(instruction)
			command = matches[1]
			startX = parseInt matches[2]
			startY = parseInt matches[3]
			endX = parseInt matches[4]
			endY = parseInt matches[5]
			switch command
				when 'turn on' then commandAction = turnOn
				when 'turn off' then commandAction = turnOff
				when 'toggle' then commandAction = toggle
			
			for currX in [startX..endX]
				for currY in [startY..endY]
					commandAction lights, currX, currY

		count = 0
		for i in [0...1000]
			for j in [0...1000]
				count += 1 if lights[i][j]

		count

	getPuzzle1Code: ->
		code = [
			@runPuzzle1.toString()
		]

		code.join '\n'

	getPuzzle2Inputs: ->
		@getPuzzle1Inputs()

	runPuzzle2: (inputs) ->
		instructions = inputs.instructions.split '\n'

		turnOn = (lights, currX, currY) ->
			lights[currX][currY] += 1

		turnOff = (lights, currX, currY) ->
			lights[currX][currY] = if lights[currX][currY] > 1 then lights[currX][currY] - 1 else 0

		toggle = (lights, currX, currY) ->
			lights[currX][currY] += 2

		lights = []
		for i in [0...1000]
			lights[i] = []
			for j in [0...1000]
				lights[i][j] = 0

		pattern = /^(turn on|toggle|turn off) (\d+),(\d+) through (\d+),(\d+)$/
		for instruction in instructions
			matches = pattern.exec(instruction)
			command = matches[1]
			startX = parseInt matches[2]
			startY = parseInt matches[3]
			endX = parseInt matches[4]
			endY = parseInt matches[5]
			switch command
				when 'turn on' then commandAction = turnOn
				when 'turn off' then commandAction = turnOff
				when 'toggle' then commandAction = toggle
			
			for currX in [startX..endX]
				for currY in [startY..endY]
					commandAction lights, currX, currY

		sum = 0
		for i in [0...1000]
			for j in [0...1000]
				sum += lights[i][j]

		sum

	getPuzzle2Code: ->
		code = [
			@runPuzzle2.toString()
		]

		code.join '\n'

module.exports =
	name: 'Day6'
	instance: Day6