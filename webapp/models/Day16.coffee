Day = require './abstract/Day.coffee'

class Day16 extends Day
  puzzle1Completed: true
  puzzle2Completed: true
  name: 'Aunt Sue'

  getPuzzle1Inputs: () ->
    [
      {label: 'Aunts', type: 'textarea', name: 'aunts'}
      {label: 'Evidence', type: 'textarea', name: 'evidence'}
    ]

  runPuzzle1: (inputs) ->
    auntData = @parseAunts inputs.aunts
    evidence = @parseEvidence inputs.evidence

    for aunt, i in auntData
      matches = true
      for key, value of evidence
        matches = false if aunt.hasOwnProperty(key) and aunt[key] isnt value

      return i + 1 if matches

  getPuzzle1Code: () ->
    code = [
      @parseAunts.toString()
      @parseEvidence.toString()
      @runPuzzle1.toString()
    ]

    code.join '\n'

  getPuzzle2Inputs: () ->
    [
      {label: 'Aunts', type: 'textarea', name: 'aunts'}
      {label: 'Evidence', type: 'textarea', name: 'evidence'}
    ]

  runPuzzle2: (inputs) ->
    auntData = @parseAunts inputs.aunts
    evidence = @parseEvidence inputs.evidence

    for aunt, i in auntData
      matches = true
      for key, value of evidence
        if key is 'cats' or key is 'trees'
          matches = false if aunt.hasOwnProperty(key) and aunt[key] <= value
        else if key is 'pomeranians' or key is 'goldfish'
          matches = false if aunt.hasOwnProperty(key) and aunt[key] >= value
        else
          matches = false if aunt.hasOwnProperty(key) and aunt[key] isnt value

      return i + 1 if matches

  getPuzzle2Code: () ->
    code = [
      @parseAunts.toString()
      @parseEvidence.toString()
      @runPuzzle1.toString()
    ]

    code.join '\n'

  parseAunts: (input) ->
    auntData = []

    strings = input.split '\n'
    pattern = /^Sue \d+: (\w+): (\d+), (\w+): (\d+), (\w+): (\d+)$/i
    for string in strings
      matches = pattern.exec string
      aunt = {}
      aunt[matches[1]] = parseInt matches[2]
      aunt[matches[3]] = parseInt matches[4]
      aunt[matches[5]] = parseInt matches[6]
      auntData.push aunt

    auntData

  parseEvidence: (input) ->
    evidence = {}
    strings = input.split '\n'
    for string in strings
      [key, value] = string.split ':'
      evidence[key] = parseInt value.trim()

    evidence

module.exports =
  name: 'Day16'
  instance: Day16