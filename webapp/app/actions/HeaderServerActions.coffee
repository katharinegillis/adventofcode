AppDispatcher   = require '../dispatcher/AppDispatcher.coffee'
HeaderConstants = require '../constants/HeaderConstants.coffee'

HeaderServerActions =
  receiveTotalStars: (total_stars) ->
    AppDispatcher.dispatch
      actionType: HeaderConstants.RECEIVE_TOTAL_STARS
      data: total_stars

module.exports = HeaderServerActions