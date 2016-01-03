controllerFactory = (app) ->
  controller =
    run: (req, res) ->
      dayId = req.params.dayId
      puzzleId = req.params.puzzleId
      inputs = req.body

      days = app.get 'models'
      if not days['Day' + dayId]?
        res.sendStatus(404)
        return

      day = new days['Day' + dayId]()

      if not day['runPuzzle' + puzzleId]?
        res.sendStatus(404)
        return

      answer = day.runPuzzle1 inputs

      res.json answer: answer

  controller

module.exports = controllerFactory