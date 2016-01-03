Day    = require './abstract/Day.coffee'
Crypto = require 'crypto'

class Day4 extends Day
  puzzle1Completed: true
  puzzle2Completed: false
  name: 'The Ideal Stocking Stuffer'

  getPuzzle1Inputs: ->
    [
      {label: 'Secret Key', type: 'text', name: 'key'}
    ]

  runPuzzle1: (inputs) ->
    found = false
    number = 0
    while not found and number <= 1000000000
      number += 1
      hash = Crypto.createHash('md5').update(inputs.key + number).digest('hex')
      found = true if hash.substring(0, 5) is '00000'

    number

  getPuzzle1Code: ->
    code = [
      @runPuzzle1.toString()
    ]

    code.join '\n'

  getPuzzle2Inputs: ->
    @getPuzzle1Inputs()

  runPuzzle2: (inputs) ->
    found = false
    number = 0
    while not found and number <= 1000000000
      number += 1
      hash = Crypto.createHash('md5').update(inputs.key + number).digest('hex')
      found = true if hash.substring(0, 6) is '000000'

    number

  getPuzzle2Code: ->
    code = [
      @runPuzzle2.toString()
    ]

    code.join '\n'

module.exports =
  name: 'Day4'
  instance: Day4