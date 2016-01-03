controllerFactory = (app) ->
  controller =
    count: (req, res) ->
      count = 0
      puzzles = app.get 'models'
      count = count + puzzle.getStars() for puzzle in puzzles

      res.json(count: count)

  controller

module.exports = controllerFactory