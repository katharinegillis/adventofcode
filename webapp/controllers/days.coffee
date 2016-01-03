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

      res.json(branches: branches)

  controller

module.exports = controllerFactory