Day = require './abstract/Day.coffee'

class Day13 extends Day
  puzzle1Completed: true
  puzzle2Completed: true
  name: 'Knights of the Dinner Table'

  getPuzzle1Inputs: () ->
    [
      {label: 'Atendees', type: 'textarea', name: 'attendees'}
    ]

  runPuzzle1: (inputs) ->
    [happinessChanges, attendees] = @parseAttendees inputs.attendees

    getGreatestHappiness = (seatedAttendees) ->
      if seatedAttendees.length is attendees.length
        happiness = 0
        for i in [0...seatedAttendees.length]
          if i is 0
            attendee1 = seatedAttendees[seatedAttendees.length - 1]
          else
            attendee1 = seatedAttendees[i - 1]

          attendee2 = seatedAttendees[i]

          happiness += happinessChanges[attendee1][attendee2]
          happiness += happinessChanges[attendee2][attendee1]

        return happiness

      greatestHappiness = NaN
      for attendee in attendees
        continue if seatedAttendees.indexOf(attendee) isnt -1

        happiness = getGreatestHappiness seatedAttendees.concat([attendee])
        greatestHappiness = happiness if isNaN(greatestHappiness) or happiness > greatestHappiness

      greatestHappiness

    getGreatestHappiness []

  getPuzzle1Code: () ->
    code = [
      @parseAttendees.toString()
      @runPuzzle1.toString()
    ]

    code.join '\n'

  getPuzzle2Inputs: () ->
    @getPuzzle1Inputs()

  runPuzzle2: (inputs) ->
    [happinessChanges, attendees] = @parseAttendeesWithMe inputs.attendees

    getGreatestHappiness = (seatedAttendees) ->
      if seatedAttendees.length is attendees.length
        happiness = 0
        for i in [0...seatedAttendees.length]
          if i is 0
            attendee1 = seatedAttendees[seatedAttendees.length - 1]
          else
            attendee1 = seatedAttendees[i - 1]

          attendee2 = seatedAttendees[i]

          happiness += happinessChanges[attendee1][attendee2]
          happiness += happinessChanges[attendee2][attendee1]

        return happiness

      greatestHappiness = NaN
      for attendee in attendees
        continue if seatedAttendees.indexOf(attendee) isnt -1

        happiness = getGreatestHappiness seatedAttendees.concat([attendee])
        greatestHappiness = happiness if isNaN(greatestHappiness) or happiness > greatestHappiness

      greatestHappiness

    getGreatestHappiness []

  getPuzzle2Code: () ->
    code = [
      @parseAttendeesWithMe.toString()
      @runPuzzle2.toString()
    ]

    code.join '\n'

  parseAttendees: (input) ->
    happinessChanges = {}
    attendees = []

    strings = input.split '\n'
    pattern = /^(\w+) would (gain|lose) (\d+) happiness units by sitting next to (\w+)\.$/i
    for string in strings
      matches = pattern.exec string

      if not happinessChanges.hasOwnProperty matches[1]
        happinessChanges[matches[1]] = {}

      happinessChanges[matches[1]][matches[4]] = if matches[2] is 'gain' then parseInt matches[3] else -1 * parseInt matches[3]

      if attendees.indexOf(matches[1]) is -1
        attendees.push matches[1]

    [happinessChanges, attendees]

  parseAttendeesWithMe: (input) ->
    happinessChanges = {me: {}}
    attendees = ['me']

    strings = input.split '\n'
    pattern = /^(\w+) would (gain|lose) (\d+) happiness units by sitting next to (\w+)\.$/i
    for string in strings
      matches = pattern.exec string

      if not happinessChanges.hasOwnProperty matches[1]
        happinessChanges[matches[1]] = {}

      happinessChanges[matches[1]][matches[4]] = if matches[2] is 'gain' then parseInt matches[3] else -1 * parseInt matches[3]
      happinessChanges[matches[1]]['me'] = 0
      happinessChanges['me'][matches[1]] = 0

      if attendees.indexOf(matches[1]) is -1
        attendees.push matches[1]

    [happinessChanges, attendees]

  module.exports =
    name: 'Day13'
    instance: Day13