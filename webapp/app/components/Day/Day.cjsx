React  = require 'react'
Header = require '../shared/Header/Header.cjsx'
Main   = require './Main.cjsx'

class Day extends React.Component
	render: ->
		dayId = parseInt @props.params.dayId
		<div>
			<Header />
			<Main dayId={dayId} />
		</div>

module.exports = Day