controllerFactory = (app) ->
  controller =
    index: (req, res) ->
      branches = []
      days = app.get 'models'
      for index in [25 .. 1]
        if days['Day' + index]?
          day = new days['Day' + index]()
          count = day.getStars()
        else
          count = 0
        branches.push
          day: index
          count: count

      res.json branches: branches

    view: (req, res) ->
      dayId = req.params.dayId

      days = app.get 'models'
      if not days['Day' + dayId]?
        res.sendStatus(404)
        return

      day = new days['Day' + dayId]()
      puzzles = []

      try
        day.getPuzzle1Inputs()
        puzzle1 =
          inputs: day.getPuzzle1Inputs()
          part: 1
          code: day.getPuzzle1Code()
      catch ex

      puzzles.push puzzle1 if puzzle1?

      try
        day.getPuzzle2Inputs()
        puzzle2 =
          inputs: day.getPuzzle2Inputs()
          part:2
          code: day.getPuzzle2Code()
      catch ex

      puzzles.push puzzle2 if puzzle2?

      res.json day:
        title: day.getTitle()
        puzzles: puzzles

  controller

module.exports = controllerFactory