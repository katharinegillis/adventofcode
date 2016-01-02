AppDispatcher = require '../dispatcher/AppDispatcher.coffee'
DayConstants = require '../constants/DayConstants.coffee'

DayServerActions =
  receiveDay: (dayId, day) ->
    AppDispatcher.dispatch
      actionType: DayConstants.RECEIVE_DAY
      data:
        dayId: dayId
        day: day

module.exports = DayServerActions