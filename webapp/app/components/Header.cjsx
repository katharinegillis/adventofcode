React      = require 'react'
TotalStars = require './TotalStars.cjsx'

class Header extends React.Component
	render: ->
		<header>
			<h1><a href="/">Advent of Code</a></h1>
			<div className="user">Tichi <TotalStars /></div>
		</header>

module.exports = Header