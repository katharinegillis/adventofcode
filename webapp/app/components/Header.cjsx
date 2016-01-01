React         = require 'react'
TotalStars    = require './TotalStars.cjsx'
HeaderStore   = require '../stores/HeaderStore.coffee'
HeaderActions = require '../actions/HeaderActions.coffee'

getHeaderState = () ->
	return total_stars: HeaderStore.getTotalStars()

class Header extends React.Component
	constructor: (props) ->
		super props
		@state = getHeaderState()
		@onChange = @onChange.bind this

	componentDidMount: () ->
		HeaderStore.addChangeListener @onChange
		HeaderActions.getTotalStars()

	componentWillUnmount: () ->
		HeaderStore.removeChangeListener @onChange

	onChange: () ->
		@setState getHeaderState()

	render: ->
		<header>
			<h1><a href="/">Advent of Code</a></h1>
			<div className="user">Tichi <TotalStars totalStars={@state.total_stars} /></div>
		</header>

module.exports = Header