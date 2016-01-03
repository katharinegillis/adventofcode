extend = require 'extend'
devConfig = require './env/development.coffee'

environment = process.env.NODE_ENV or 'development'

defaults = {
  base_url: process.env.BASE_URL
}

switch environment
  when 'development' then config = extend true, defaults, devConfig

module.exports = config