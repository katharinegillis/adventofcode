Day = require './abstract/Day.coffee'

class Day1 extends Day
  puzzle1Completed: true
  puzzle2Completed: false
  name: 'Not Quite Lisp'

  getPuzzle1Inputs: ->
    [
      {label: 'Instructions', type: 'text', name: 'instructions'}
    ]

  runPuzzle1: (inputs) ->
    upCount = inputs.instructions.replace /\)/g, ''
      .length

    downCount = inputs.instructions.replace /\(/g, ''
      .length

    upCount - downCount

  getPuzzle1Code: ->
    code = [
      @runPuzzle1.toString()
    ]

    code.join '\n'

  getPuzzle2Inputs: ->
    @getPuzzle1Inputs()

  runPuzzle2: (inputs) ->
    floor = 0
    for char, index in inputs.instructions
      floor += if char is '(' then 1 else -1
      break if floor is -1

    index + 1

  getPuzzle2Code: ->
    code = [
      @runPuzzle2.toString()
    ]

    code.join '\n'

module.exports =
  name: 'Day1'
  instance: Day1