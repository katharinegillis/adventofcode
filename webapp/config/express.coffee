# @file
# @author katharinegillis
# @date   12/24/15
# @brief  Configure the ExpressJS server.

# Module dependencies.
express        = require 'express'
compression    = require 'compression'
winston        = require 'winston'
expressWinston = require 'express-winston'
bodyParser     = require 'body-parser'
methodOverride = require 'method-override'
jade           = require 'jade'
session        = require 'express-session'

pkg    = require '../package.json'
config = require './config'

# Configure the server.
expressConfig = (app) ->
  # Set up the compression middleware.
  app.use compression({threshold: 512})

  # Set up the static files midleware.
  app.use express.static(config.root + '/public')

  # Set up the logging.
  logger = new (winston.Logger)(config.logger)
  app.set 'logger', logger

  # Set up the views.
  app.set 'views', config.root + '/views'
  app.set 'view engine', 'jade'

  # Set up the request parsers.
  app.use bodyParser.json()
  app.use bodyParser.urlencoded({extended: true})
  app.use methodOverride((req, res) ->
    if req.body and typeof req.body is 'object' and '_method' in req.body
      # Look in urlencoded POST bodies and delete it.
      method = req.body._method
      delete req.body._method
      method
  )

  # Set up the session parsers.
  app.use session({
    resave: false
    saveUninitialized: true
    secret: pkg.name
  })

  # Set up access logging.
  app.use expressWinston.logger({winstonInstance: logger})

# Expose the module.
module.exports = expressConfig