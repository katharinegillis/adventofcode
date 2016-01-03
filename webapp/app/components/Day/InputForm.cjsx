React          = require 'react'
ReactPropTypes = React.PropTypes
Input          = require './Input.cjsx'
AnswerActions  = require '../../actions/AnswerActions.coffee'
AnswerStore    = require '../../stores/AnswerStore.coffee'

class InputForm extends React.Component
	constructor: (props) ->
		super props
		@state =
			inputs: {},
			running: false
		@state.inputs[key] = '' for input, key in @props.inputs
		@onAnswer = @onAnswer.bind this

	@propTypes:
		inputs: ReactPropTypes.array.isRequired
		dayId: ReactPropTypes.number.isRequired
		puzzleId: ReactPropTypes.number.isRequired
		onViewCode: ReactPropTypes.func.isRequired

	onInputChange: (key, value) ->
		state = @state
		state.inputs[key] = value
		@setState state

	onSubmit: ->
		state = @state
		state.running = true
		@setState state

		data = {}
		data[input.name] = @state.inputs[key] for input, key in @props.inputs
		AnswerActions.getAnswer @props.dayId, @props.puzzleId, data

	componentDidMount: ->
		AnswerStore.addChangeListener @onAnswer

	componentWillUnmount: ->
		AnswerStore.removeChangeListener @onAnswer

	onAnswer: ->
		state = @state
		state.running = false
		@setState state

	render: ->
		inputs = []
		inputs.push <Input label={input.label} type={input.type} name={input.name} key={key} onInputChange={@onInputChange.bind(this, key)} /> for input, key in @props.inputs

		disabled = if @state.running then 'disabled' else null

		<div className="form">
			{inputs}
			<p>
				<input type="submit" value="[Submit]" onClick={@onSubmit.bind this} className={disabled} disabled={disabled} />
				<input type="submit" value="[View Code]" onClick={@props.onViewCode} />
			</p>
		</div>

module.exports = InputForm