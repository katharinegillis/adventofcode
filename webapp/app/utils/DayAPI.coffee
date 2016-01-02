Request = require 'request'

module.exports =
  getDay: (dayId, callback) ->
    # TODO Make a request to an external API for the data.
    if dayId is 25
      day =
        title: "Not Quite Lisp"
        puzzles: [
          {part: 1, inputs: [
            {label: 'Instructions', name: 'instructions', type: 'text'},
            {label: 'Textarea', name: 'textarea', type: 'textarea'}
          ], code: 'return 12345;'},
          {part: 2, inputs: [], code: 'return 4321;'}
        ]
    else
      day = {}

    callback(null, day)