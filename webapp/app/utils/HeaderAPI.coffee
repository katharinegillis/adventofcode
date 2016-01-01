Request = require 'request'

module.exports =
  getTotalStars: (callback) ->
    # TODO Make a request to an external API for the data.
    total_stars = 19

    callback(null, total_stars)