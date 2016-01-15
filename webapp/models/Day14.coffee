Day = require './abstract/Day.coffee'

class Day14 extends Day
  puzzle1Completed: true
  puzzle2Completed: true
  name: 'Reindeer Olympics'

  getPuzzle1Inputs: () ->
    [
      {label: 'Reindeer Stats', type: 'textarea', name: 'reindeer_stats'}
      {label: 'Time', type: 'text', name: 'time'}
    ]

  runPuzzle1: (inputs) ->
    reindeers = @parseReindeer inputs.reindeer_stats
    time = inputs.time

    maxDistance = -1
    for name, reindeer of reindeers
      interval = reindeer.flying_time + reindeer.resting_time
      remainder = time % interval
      numIntervals = Math.floor time / interval

      distance = numIntervals * reindeer.flying_time * reindeer.speed
      if remainder > reindeer.flying_time
        distance += reindeer.flying_time * reindeer.speed
      else
        distance += remainder * reindeer.speed

      maxDistance = distance if maxDistance < distance

    maxDistance

  getPuzzle1Code: () ->
    code = [
      @parseReindeer.toString()
      @runPuzzle1.toString()
    ]

    code.join '\n'

  getPuzzle2Inputs: () ->
    @getPuzzle1Inputs()

  runPuzzle2: (inputs) ->
    reindeers = @parseReindeer inputs.reindeer_stats
    time = inputs.time

    getFastestReindeer = (curretTime) ->
      maxDistance = -1
      fastestNames = []
      for name, reindeer of reindeers
        interval = reindeer.flying_time + reindeer.resting_time
        remainder = curretTime % interval
        numIntervals = Math.floor curretTime / interval

        distance = numIntervals * reindeer.flying_time * reindeer.speed
        if remainder > reindeer.flying_time
          distance += reindeer.flying_time * reindeer.speed
        else
          distance += remainder * reindeer.speed

        if maxDistance < distance
          maxDistance = distance
          fastestNames = [name]
        else if maxDistance is distance
          fastestNames.push name

      fastestNames

    reindeer_points = {}
    for i in [1..time]
      fastestReindeers = getFastestReindeer i

      for reindeer in fastestReindeers
        if not reindeer_points.hasOwnProperty(reindeer)
          reindeer_points[reindeer] = 0

        reindeer_points[reindeer] += 1

    maxPoints = -1
    for reindeer, points of reindeer_points
      maxPoints = points if maxPoints < points

    maxPoints

  getPuzzle2Code: () ->
    code = [
      @parseReindeer.toString()
      @runPuzzle2.toString()
    ]

    code.join '\n'

  parseReindeer: (input) ->
    reindeers = {}

    strings = input.split '\n'
    pattern = /^(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds\./i
    for string in strings
      matches = pattern.exec string
      reindeers[matches[1]] =
        speed: parseInt matches[2]
        flying_time: parseInt matches[3]
        resting_time: parseInt matches[4]

    reindeers

module.exports =
  name: 'Day14'
  instance: Day14