React          = require 'react'
ReactPropTypes = React.PropTypes
DayStore       = require '../../stores/DayStore.coffee'
DayActions     = require '../../actions/DayActions.coffee'

getCodeState = (dayId, puzzleId) ->
	data = DayStore.getDay dayId
	code: if data.puzzles? and data.puzzles[puzzleId - 1] then data.puzzles[puzzleId - 1].code else ''

class Code extends React.Component
	constructor: (props) ->
		super props
		@state = getCodeState parseInt(props.params.dayId), parseInt(props.params.puzzleId)
		@onChange = @onChange.bind this

	componentDidMount: ->
		DayStore.addChangeListener @onChange
		DayActions.getDay parseInt(@props.params.dayId)

	componentWillUnmount: ->
		DayStore.removeChangeListener @onChange

	onChange: ->
		@setState getCodeState parseInt(@props.params.dayId), parseInt(@props.params.puzzleId)

	render: ->
		<code>
			{@state.code}
		</code>

module.exports = Code