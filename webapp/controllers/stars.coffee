controllerFactory = (app) ->
  controller =
    count: (req, res) ->
      count = 0
      days = app.get 'models'
      for index in Object.keys(days)
        day = new days[index]()
        count = count + day.getStars()

      res.json(count: count)

  controller

module.exports = controllerFactory