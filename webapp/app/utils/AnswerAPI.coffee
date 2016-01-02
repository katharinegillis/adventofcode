Request = require 'request'

module.exports =
  getAnswer: (dayId, puzzleId, data, callback) ->
    console.log data
    # TODO Make a request to an external API for the data.
    if dayId is 25 and puzzleId is 1
      answer = 12345
    else
      answer = ''

    callback(null, answer)