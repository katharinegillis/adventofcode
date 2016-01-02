AppDispatcher = require '../dispatcher/AppDispatcher.coffee'
AnswerConstants = require '../constants/AnswerConstants.coffee'

AnswerServerActions =
  receiveAnswer: (dayId, puzzleId, answer) ->
    AppDispatcher.dispatch
      actionType: AnswerConstants.RECEIVE_ANSWER
      data:
        dayId: dayId
        puzzleId: puzzleId
        answer: answer

module.exports = AnswerServerActions