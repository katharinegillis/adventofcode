AppDispatcher = require '../dispatcher/AppDispatcher.coffee'
EventEmitter  = require('events').EventEmitter
assign        = require 'object-assign'
DayConstants  = require '../constants/DayConstants.coffee'

_data =
  days: {}

CHANGE_EVENT = 'change'

DayStore = assign {}, EventEmitter.prototype,
  getDay: (dayId) ->
    _data.days[dayId] or {}

  emitChange: ->
    @emit CHANGE_EVENT

  addChangeListener: (callback) ->
    @on CHANGE_EVENT, callback

  removeChangeListener: (callback) ->
    @removeListener CHANGE_EVENT, callback

AppDispatcher.register (action) ->
  switch action.actionType
    when DayConstants.RECEIVE_DAY
      _data.days[action.data.dayId] = action.data.day
      DayStore.emitChange()

module.exports = DayStore