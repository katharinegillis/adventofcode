AppDispatcher       = require '../dispatcher/AppDispatcher.coffee'
HeaderConstants     = require '../constants/HeaderConstants.coffee'
HeaderAPI           = require '../utils/HeaderAPI.coffee'
Promise             = require 'bluebird'
HeaderServerActions = require '../actions/HeaderServerActions.coffee'

Promise.promisifyAll HeaderAPI

HeaderActions =
  getTotalStars: ->
    AppDispatcher.dispatch actionType: HeaderConstants.GET_TOTAL_STARS
    HeaderAPI.getTotalStarsAsync()
      .then (total_stars) ->
        HeaderServerActions.receiveTotalStars(total_stars)
      .catch (error) ->
        console.log error

module.exports = HeaderActions