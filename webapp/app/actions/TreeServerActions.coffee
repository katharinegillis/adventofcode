AppDispatcher = require '../dispatcher/AppDispatcher.coffee'
TreeConstants = require '../constants/TreeConstants.coffee'

TreeServerActions =
  receiveBranches: (branches) ->
    AppDispatcher.dispatch
      actionType: TreeConstants.RECEIVE_BRANCHES
      data: branches

module.exports = TreeServerActions