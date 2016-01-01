AppDispatcher     = require '../dispatcher/AppDispatcher.coffee'
TreeConstants     = require '../constants/TreeConstants.coffee'
TreeAPI           = require '../utils/TreeAPI.coffee'
Promise           = require 'bluebird'
TreeServerActions = require '../actions/TreeServerActions.coffee'

Promise.promisifyAll TreeAPI

TreeActions =
  getBranches: ->
    AppDispatcher.dispatch actionType: TreeConstants.GET_BRANCHES
    TreeAPI.getBranchesAsync()
      .then (branches) ->
        TreeServerActions.receiveBranches(branches)
      .catch (error) ->
        console.log error

module.exports = TreeActions