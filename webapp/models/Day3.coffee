Day = require './abstract/Day.coffee'

class Day3 extends Day
  puzzle1Completed: true
  puzzle2Completed: true
  name: 'Perfectly Spherical Houses in a Vacuum'

  getPuzzle1Inputs: ->
    [
      {label: 'Directions', type: 'text', name: 'directions'}
    ]

  runPuzzle1: (inputs) ->
    coordinatesVisited = '0,0': true
    currentX = 0
    currentY = 0
    for char in inputs.directions
      switch char
        when '^' then currentY += 1
        when 'v' then currentY -= 1
        when '>' then currentX += 1
        when '<' then currentX -= 1

      coordinatesVisited[currentX + ',' + currentY] = true

    Object.keys(coordinatesVisited).length

  getPuzzle1Code: ->
    code = [
      @runPuzzle1.toString()
    ]

    code.join '\n'

  getPuzzle2Inputs: ->
    @getPuzzle1Inputs()

  runPuzzle2: (inputs) ->
    coordinatesVisited = '0,0': true
    santaCoordinates =
      x: 0
      y: 0
    roboSantaCoordinates =
      x: 0
      y: 0

    for char, index in inputs.directions
      actor = if index % 2 is 0 then santaCoordinates else roboSantaCoordinates
      switch char
        when '^' then actor.y += 1
        when 'v' then actor.y -= 1
        when '>' then actor.x += 1
        when '<' then actor.x -= 1

      coordinatesVisited[actor.x + ',' + actor.y] = true

    Object.keys(coordinatesVisited).length

  getPuzzle2Code: ->
    code = [
      @runPuzzle2.toString()
    ]

    code.join '\n'

module.exports =
  name: 'Day3'
  instance: Day3