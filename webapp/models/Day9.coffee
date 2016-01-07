Day = require './abstract/Day.coffee'

class Day9 extends Day
	puzzle1Completed: true
	puzzle2Completed: true
	name: 'All in a Single Night'

	getPuzzle1Inputs: () ->
		[
			{label: 'Distances', type: 'textarea', name: 'distances'}
		]

	runPuzzle1: (inputs) ->
		[distances, cities] = @parseDistances inputs.distances

		getShortestDistance = (visitedCities) ->
			if visitedCities.length is cities.length
				distance = 0
				for i in [1...visitedCities.length]
					city1 = visitedCities[i - 1]
					city2 = visitedCities[i]

					if distances.hasOwnProperty(city1) and distances[city1].hasOwnProperty(city2)
						distance = distance + distances[city1][city2]
					else
						distance = distance + distances[city2][city1]

				return distance

			shortestDistance = -1
			for city in cities
				continue if visitedCities.indexOf(city) isnt -1

				distance = getShortestDistance visitedCities.concat([city])
				shortestDistance = distance if shortestDistance is -1 or distance < shortestDistance

			shortestDistance

		getShortestDistance []


	getPuzzle1Code: () ->
		code = [
			@parseDistances.toString()
			@runPuzzle1.toString()
		]

		code.join '\n'

	getPuzzle2Inputs: () ->
		@getPuzzle1Inputs()

	runPuzzle2: (inputs) ->
		[distances, cities] = @parseDistances inputs.distances

		getLongestDistance = (visitedCities) ->
			if visitedCities.length is cities.length
				distance = 0
				for i in [1...visitedCities.length]
					city1 = visitedCities[i - 1]
					city2 = visitedCities[i]

					if distances.hasOwnProperty(city1) and distances[city1].hasOwnProperty(city2)
						distance = distance + distances[city1][city2]
					else
						distance = distance + distances[city2][city1]

				return distance

			longestDistance = -1
			for city in cities
				continue if visitedCities.indexOf(city) isnt -1

				distance = getLongestDistance visitedCities.concat([city])
				longestDistance = distance if longestDistance is -1 or distance > longestDistance

			longestDistance

		getLongestDistance []

	getPuzzle2Code: () ->
		code = [
			@parseDistances.toString(),
			@runPuzzle2.toString()
		]

		code.join '\n'

	parseDistances: (input) ->
		distances = {}
		cities = []

		strings = input.split '\n'
		pattern = /^(\w+) to (\w+) = (\d+)$/i
		for string in strings
			matches = pattern.exec string

			if not distances.hasOwnProperty matches[1]
				distances[matches[1]] = {}

			distances[matches[1]][matches[2]] = parseInt matches[3]

			if cities.indexOf(matches[1]) is -1
				cities.push matches[1]

			if cities.indexOf(matches[2]) is -1
				cities.push matches[2]

		[distances, cities]


module.exports =
	name: 'Day9'
	instance: Day9