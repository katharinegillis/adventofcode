AppDispatcher   = require '../dispatcher/AppDispatcher.coffee'
EventEmitter    = require('events').EventEmitter
assign          = require 'object-assign'
AnswerConstants = require '../constants/AnswerConstants.coffee'

_data = {}

CHANGE_EVENT = 'change'

AnswerStore = assign {}, EventEmitter.prototype,
  getAnswer: (dayId, puzzleId) ->
    answer = if _data['' + dayId + puzzleId]? then _data['' + dayId + puzzleId] else ''
    answer

  emitChange: ->
    @emit CHANGE_EVENT

  addChangeListener: (callback) ->
    @on CHANGE_EVENT, callback

  removeChangeListener: (callback) ->
    @removeListener CHANGE_EVENT, callback

AppDispatcher.register (action) ->
  switch action.actionType
    when AnswerConstants.RECEIVE_ANSWER
      _data['' + action.data.dayId + action.data.puzzleId] = action.data.answer
      console.log _data
      AnswerStore.emitChange()

module.exports = AnswerStore