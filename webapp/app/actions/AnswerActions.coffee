AppDispatcher       = require '../dispatcher/AppDispatcher.coffee'
AnswerConstants     = require '../constants/AnswerConstants.coffee'
AnswerAPI           = require '../utils/AnswerAPI.coffee'
Promise             = require 'bluebird'
AnswerServerActions = require './AnswerServerActions.coffee'

Promise.promisifyAll AnswerAPI

AnswerActions =
  getAnswer: (dayId, puzzleId, data) ->
    AppDispatcher.dispatch actionType: AnswerConstants.GET_ANSWER
    AnswerAPI.getAnswerAsync dayId, puzzleId, data
      .then (answer) ->
        AnswerServerActions.receiveAnswer dayId, puzzleId, answer
      .catch (error) ->
        console.log error
        AnswerServerActions.receiveAnswer dayId, puzzleId, ''

module.exports = AnswerActions