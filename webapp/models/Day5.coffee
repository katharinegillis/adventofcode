Day = require './abstract/Day.coffee'

class Day5 extends Day
  puzzle1Completed: true
  puzzle2Completed: true
  name: 'Doesn\'t He Have Intern-Elves For This?'

  getPuzzle1Inputs: ->
    [
      {label: 'List', type: 'textarea', name: 'list'}
    ]

  runPuzzle1: (inputs) ->
    strings = inputs.list.split '\n'
    niceStrings = 0
    pattern1 = /[aeiou].*[aeiou].*[aeiou]/
    pattern2 = /([a-zA-Z])\1/
    pattern3 = /(?:ab|cd|pq|xy)/
    for testString in strings
      niceStrings += 1 if pattern1.test(testString) and pattern2.test(testString) and not pattern3.test(testString)

    niceStrings

  getPuzzle1Code: ->
    code = [
      @runPuzzle1.toString()
    ]

    code.join '\n'

  getPuzzle2Inputs: ->
    @getPuzzle1Inputs()

  runPuzzle2: (inputs) ->
    strings = inputs.list.split '\n'
    niceStrings = 0
    pattern1 = /([a-zA-Z]{2}).*\1/
    pattern2 = /([a-zA-Z]).\1/
    for testString in strings
      niceStrings += 1 if pattern1.test(testString) and pattern2.test(testString)

    niceStrings

  getPuzzle2Code: ->
    code = [
      @runPuzzle2.toString()
    ]

    code.join '\n'

module.exports =
  name: 'Day5'
  instance: Day5