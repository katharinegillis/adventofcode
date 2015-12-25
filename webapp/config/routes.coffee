# @file
# @author katharinegillis
# @date   12/24/15
# @brief  Configure the routes.

# Module dependencies
expressWinston = require 'express-winston'

routesConfig = (app) ->
  index = require('../controllers/index')(app)

  # Main routes.
  app.get '/', index.index

  # Error routes.
  # Set up error logging.
  app.use expressWinston.errorLogger({winstonInstance: app.get 'logger'})

  # Set up the 500 internal server error.
  app.use (err, req, res, next) ->
    if err.message and err.message.indexOf('not found') isnt -1 and err.message.indexOf('Cast to ObjectId failed')
      return next()

    app.get 'logger'
      .error 'Error: ' + JSON.stringify(err)

    # Show the error page.
    data = {}
    if app.get('env') is 'development'
      data.error = err.stack
    res.status 500
      .render '500', data

    # Set up the 404 not found error.
    app.use (req, res, next) ->
      res.status 404
        .render '404', {
          url: req.originalUrl
          error: 'Not found'
        }

# Expose the module.
module.exports = routesConfig