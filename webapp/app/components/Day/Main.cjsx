React          = require 'react'
ReactPropTypes = React.PropTypes
Title          = require './Title.cjsx'
Puzzle         = require './Puzzle.cjsx'
Error          = require '../shared/Error.cjsx'
DayStore       = require '../../stores/DayStore.coffee'
DayActions     = require '../../actions/DayActions.coffee'

getDayState = (dayId) ->
	day: DayStore.getDay dayId

class Main extends React.Component
	constructor: (props) ->
		super props
		@state = getDayState()
		@onChange = @onChange.bind this

	@propTypes:
		dayId: ReactPropTypes.number.isRequired

	componentDidMount: ->
		DayStore.addChangeListener @onChange
		DayActions.getDay @props.dayId

	componentWillUnmount: ->
		DayStore.removeChangeListener @onChange

	componentWillReceiveProps: (nextProps) ->
		DayActions.getDay nextProps.dayId

	onChange: ->
		@setState getDayState @props.dayId

	render: ->
		if Object.keys(@state.day).length < 1
			return <main><Error message="This day hasn't been coded yet." /></main>

		puzzles = []
		puzzles.push <Puzzle key={key} dayId={@props.dayId} puzzle={puzzle} /> for puzzle, key in @state.day.puzzles

		<div>
			<Title title="--- Day #{@props.dayId}: #{@state.day.title} ---" />
			{puzzles}
		</div>

module.exports = Main