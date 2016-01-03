AppDispatcher    = require '../dispatcher/AppDispatcher.coffee'
DayConstants     = require '../constants/DayConstants.coffee'
DayAPI           = require '../utils/DayAPI.coffee'
Promise          = require 'bluebird'
DayServerActions = require './DayServerActions.coffee'

Promise.promisifyAll DayAPI

DayActions =
  getDay: (dayId) ->
    AppDispatcher.dispatch actionType: DayConstants.GET_DAY
    DayAPI.getDayAsync dayId
      .then (day) ->
        DayServerActions.receiveDay dayId, day
      .catch (error) ->
        console.log error

module.exports = DayActions