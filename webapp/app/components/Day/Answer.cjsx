React          = require 'react'
ReactPropTypes = React.PropTypes
AnswerStore    = require '../../stores/AnswerStore.coffee'

getAnswerState = (dayId, puzzleId) ->
	value: AnswerStore.getAnswer dayId, puzzleId

class Answer extends React.Component
	constructor: (props) ->
		super props
		@state = getAnswerState @props.dayId, @props.puzzleId
		@onChange = @onChange.bind this

	@propTypes:
		dayId: ReactPropTypes.number.isRequired
		puzzleId: ReactPropTypes.number.isRequired

	componentDidMount: ->
		AnswerStore.addChangeListener @onChange

	componentWilUnmount: ->
		AnswerSotre.removeChangeListener @onChange

	onChange: (event) ->
		@setState getAnswerState @props.dayId, @props.puzzleId

	render: ->
		console.log @state
		if @state.value is ''
			return null

		<div className="answer">
			Your puzzle answer is <code>{@state.value}</code>.
		</div>

module.exports = Answer