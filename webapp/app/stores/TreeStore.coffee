AppDispatcher = require '../dispatcher/AppDispatcher.coffee'
EventEmitter  = require('events').EventEmitter
assign        = require 'object-assign'
TreeConstants = require '../constants/TreeConstants.coffee'

_branches = []

CHANGE_EVENT = 'change'

TreeStore = assign {}, EventEmitter.prototype,
  getBranches: ->
    _branches

  emitChange: ->
    @emit CHANGE_EVENT

  addChangeListener: (callback) ->
    @on CHANGE_EVENT, callback

  removeChangeListener: (callback) ->
    @removeListener CHANGE_EVENT, callback

AppDispatcher.register (action) ->
  switch action.actionType
    when TreeConstants.RECEIVE_BRANCHES
      _branches = action.data
      TreeStore.emitChange()


module.exports = TreeStore