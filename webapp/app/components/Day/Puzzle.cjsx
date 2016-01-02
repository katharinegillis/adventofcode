React          = require 'react'
ReactPropTypes = React.PropTypes
Title          = require './Title.cjsx'
InputForm      = require './InputForm.cjsx'
Answer         = require './Answer.cjsx'

class Puzzle extends React.Component
	@propTypes:
		puzzle: ReactPropTypes.object.isRequired
		dayId: ReactPropTypes.number.isRequired

	onViewCode: ->
		window.open '/#/code/' + @props.dayId + '/' + @props.puzzle.part, '_blank', 'resizable=1'

	render: ->
		switch @props.puzzle.part
			when 1 then part = "One"
			when 2 then part = "Two"
			else part = "Unknown"

		<div className="puzzle">
			<Title title="--- Part #{part} ---" />
			<InputForm inputs={@props.puzzle.inputs} dayId={@props.dayId} puzzleId={@props.puzzle.part} onViewCode={@onViewCode.bind(this)} />
			<Answer dayId={@props.dayId} puzzleId={@props.puzzle.part} />
		</div>

module.exports = Puzzle