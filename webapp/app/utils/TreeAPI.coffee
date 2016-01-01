Request = require 'request'

module.exports =
  getBranches: (callback) ->
    # TODO Make a request to an external API for the data.
    branches = [
      {day: 25, count: 0},
      {day: 24, count: 0},
      {day: 23, count: 0},
      {day: 22, count: 0},
      {day: 21, count: 0},
      {day: 20, count: 0},
      {day: 19, count: 0},
      {day: 18, count: 0},
      {day: 17, count: 0},
      {day: 16, count: 0},
      {day: 15, count: 0},
      {day: 14, count: 0},
      {day: 13, count: 0},
      {day: 12, count: 0},
      {day: 11, count: 0},
      {day: 10, count: 1},
      {day: 9, count: 2},
      {day: 8, count: 2},
      {day: 7, count: 2},
      {day: 6, count: 2},
      {day: 5, count: 2},
      {day: 4, count: 2},
      {day: 3, count: 2},
      {day: 2, count: 2},
      {day: 1, count: 2}
    ]

    callback(null, branches)