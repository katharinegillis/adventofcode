Day = require './abstract/Day.coffee'

class Day2 extends Day
  puzzle1Completed: true
  puzzle2Completed: true
  name: 'I Was Told There Would Be No Math'

  getPuzzle1Inputs: ->
    [
      {label: 'Dimensions', type: 'textarea', name: 'dimensions'}
    ]

  runPuzzle1: (inputs) ->
    dimensions = @parseDimensions(inputs.dimensions)
    paperArea = 0
    paperArea += 2*sides[0]*sides[1] + 2*sides[1]*sides[2] + 2*sides[2]*sides[0] + sides[0]*sides[1] for sides in dimensions
    paperArea

  getPuzzle1Code: ->
    code = [
      @parseDimensions.toString()
      @runPuzzle1.toString()
    ]

    code.join '\n'

  getPuzzle2Inputs: ->
    @getPuzzle1Inputs()

  runPuzzle2: (inputs) ->
    dimensions = @parseDimensions(inputs.dimensions)
    ribbonLength = 0
    ribbonLength += 2*sides[0] + 2*sides[1] + sides[0]*sides[1]*sides[2] for sides in dimensions
    ribbonLength

  getPuzzle2Code: ->
    code = [
      @parseDimensions.toString()
      @runPuzzle2.toString()
    ]

    code.join '\n'

  parseDimensions: (data) ->
    dimensions = []
    lines = data.split '\n'
    pattern = /^(\d+)x(\d+)x(\d+)$/
    for line in lines
      matches = line.match(pattern)
      sides = [ parseInt(matches[1]), parseInt(matches[2]), parseInt(matches[3]) ]
      sides.sort (a, b) ->
        return 1 if a > b
        return 0 if a is b
        -1
      dimensions.push sides

    dimensions


module.exports =
  name: 'Day2'
  instance: Day2