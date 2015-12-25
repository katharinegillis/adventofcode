# @file
# @author katharinegillis
# @date   12/24/15
# @brief  Defines the index actions.

# Module dependencies.
extend = require 'extend'
url    = require 'url'

config = require '../config/config'

controllerFactory = (app) ->
  controller =
    # Displays the main page.
    #
    # @param  object  req  The request object.
    # @param  object  res  The response object.
    index: (req, res) ->
      res.render 'index'

  controller

# Expose the module.
module.exports = controllerFactory