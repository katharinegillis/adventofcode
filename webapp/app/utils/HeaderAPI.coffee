Request = require 'request'
Url = require 'url'

config = require '../config/config.coffee'

module.exports =
  getTotalStars: (callback) ->
    Request.get {
      url: Url.resolve config.base_url, '/api/stars/count'
    }, (error, response, body) ->
      if not error and response.statusCode is 200
        body = JSON.parse body
        callback null, body.count
      else
        if not error
          error =
            statusCode: response.statusCode
            body: body

        callback error, null