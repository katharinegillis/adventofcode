Day = require './abstract/Day.coffee'

class Day1 extends Day
  puzzle1Completed: true
  puzzle2Completed: false
  name: 'Not Quite Lisp'

  getPuzzle1Inputs: () ->
    [
      {label: 'Instructions', type: 'text', name: 'instructions'}
    ]

  runPuzzle1: (inputs) ->
    upCount = inputs.instructions.replace /\)/g, ''
      .length

    downCount = inputs.instructions.replace /\(/g, ''
      .length

    upCount - downCount

  getPuzzle1Code: () ->
    code = [
      @runPuzzle1.toString()
    ]

    code.join '\n'

module.exports =
  name: 'Day1'
  instance: Day1