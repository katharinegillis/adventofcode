Request = require 'request'
Url     = require 'url'

config = require '../config/config.coffee'

module.exports =
  getDay: (dayId, callback) ->
    Request.get {
      url: Url.resolve config.base_url, '/api/days/' + dayId
    }, (error, response, body) ->
      if not error and response.statusCode is 200
        body = JSON.parse body
        callback null, body.day
      else if not error and response.statusCode is 404
        callback null, {}
      else
        if not error
          error =
            statusCode: response.statusCode
            body: body

        callback error, null