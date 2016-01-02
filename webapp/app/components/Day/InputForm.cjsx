React          = require 'react'
ReactPropTypes = React.PropTypes
Input          = require './Input.cjsx'
AnswerActions  = require '../../actions/AnswerActions.coffee'

class InputForm extends React.Component
	constructor: (props) ->
		super props
		@state = {}
		@state[key] = '' for input, key in @props.inputs

	@propTypes:
		inputs: ReactPropTypes.array.isRequired
		dayId: ReactPropTypes.number.isRequired
		puzzleId: ReactPropTypes.number.isRequired
		onViewCode: ReactPropTypes.func.isRequired

	onInputChange: (key, value) ->
		state = @state
		state[key] = value
		@setState state

	onSubmit: ->
		data = {}
		data[input.name] = @state[key] for input, key in @props.inputs
		AnswerActions.getAnswer @props.dayId, @props.puzzleId, data

	render: ->
		inputs = []
		inputs.push <Input label={input.label} type={input.type} name={input.name} key={key} onInputChange={@onInputChange.bind(this, key)} /> for input, key in @props.inputs

		<div className="form">
			{inputs}
			<p>
				<input type="submit" value="[Submit]" onClick={@onSubmit.bind this} />
				<input type="submit" value="[View Code]" onClick={@props.onViewCode} />
			</p>
		</div>

module.exports = InputForm