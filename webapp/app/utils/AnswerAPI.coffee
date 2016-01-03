Request = require 'request'
Url     = require 'url'

config = require '../config/config.coffee'

module.exports =
  getAnswer: (dayId, puzzleId, data, callback) ->
    Request.post {
      url: Url.resolve config.base_url, '/api/answers/' + dayId + '/' + puzzleId
      json: data
    }, (error, response, body) ->
      if not error and response.statusCode is 200
        callback null, body.answer
      else if not error and response.statusCode is 404
        callback null, 'Puzzle not found'
      else
        if not error
          error = statusCode: response.statusCode
          body: body

        callback error, null