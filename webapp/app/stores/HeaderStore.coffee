AppDispatcher   = require '../dispatcher/AppDispatcher.coffee'
EventEmitter    = require('events').EventEmitter
assign          = require 'object-assign'
HeaderConstants = require '../constants/HeaderConstants.coffee'

_data =
  total_stars: 0

CHANGE_EVENT = 'change'

HeaderStore = assign {}, EventEmitter.prototype,
  getTotalStars: ->
    _data.total_stars

  emitChange: ->
    @emit CHANGE_EVENT

  addChangeListener: (callback) ->
    @on CHANGE_EVENT, callback

  removeChangeListener: (callback) ->
    @removeListener CHANGE_EVENT, callback

AppDispatcher.register (action) ->
  switch action.actionType
    when HeaderConstants.RECEIVE_TOTAL_STARS
      _data.total_stars = action.data
      HeaderStore.emitChange()

module.exports = HeaderStore