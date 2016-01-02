React          = require 'react'
ReactPropTypes = React.PropTypes

class Input extends React.Component
	constructor: (props) ->
		super props
		@state = value: ''

	@propTypes:
		name: ReactPropTypes.string.isRequired
		label: ReactPropTypes.string.isRequired
		onInputChange: ReactPropTypes.func.isRequired

	onChange: (event) ->
		@setState value: event.target.value
		@props.onInputChange @state.value

	onBlur: (event) ->
		@setState value: event.target.value
		@props.onInputChange @state.value

	render: ->
		switch @props.type
			when 'text' then input = <input type="text" name={@props.name} onChange={@onChange.bind this} onBlur={@onBlur.bind this} autoComplete="off" />
			when 'textarea' then input = <textarea name={@props.name} onChange={@onChange.bind this} onBlur={@onBlur.bind this} autoComplete="off" rows="5"></textarea>
			else input = ''

		<p>
			{@props.label}:&nbsp;
			{input}
		</p>

module.exports = Input