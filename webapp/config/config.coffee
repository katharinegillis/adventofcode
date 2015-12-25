# @file
# @author katharinegillis
# @date   12/24/15
# @brief  Defines the server configuration.

# Module dependencies.
join    = require('path').join
extend  = require 'extend'
fs      = require 'fs'
winston = require 'winston'

# Add in the environmental settings.
environment = process.env.NODE_ENV or 'development'
envConfig = require './env/' + environment

# Set up the default configuration.
defaults =
  root: join __dirname, '..'
  baseurl: process.env.BASE_URL
  logger:
    transports: [
      new winston.transports.Console {
        colorize: true
        level: 'debug'
      }
      new winston.transports.File {
        filename: 'logs/error.log'
        level: 'error'
        name: 'error-file'
        json: false
      }
      new winston.transports.File {
        filename: 'logs/system.log'
        level: 'debug'
        name: 'system-file'
        json: false
      }
    ]
  cookie:
    secret: process.env.COOKIE_SECRET

config = extend true, defaults, envConfig

# Expose the module.
module.exports = config