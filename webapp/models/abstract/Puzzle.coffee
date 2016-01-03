class Puzzle
  puzzle1Completed: false
  puzzle2Completed: false
  getStars: ->
    if @puzzle1Completed and @puzzle2Completed
      2
    else if @puzzle1Completed or @puzzle2Completed
      1
    else
      0

  getPuzzle1Inputs: () ->
    throw "Not implemented"

  runPuzzle1: (inputs) ->
    throw "Not implemented"

  getPuzzle1Code: () ->
    throw "Not implemented"

  getPuzzle2Inputs: () ->
    throw "Not implemented"

  runPuzzle2: (inputs) ->
    throw "Not implemented"

  getPuzzle2Code: () ->
    throw "Not implemented"