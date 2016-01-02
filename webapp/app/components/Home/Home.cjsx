React  = require 'react'
Header = require '../shared/Header/Header.cjsx'
Main   = require './Main.cjsx'

class Home extends React.Component
	render: ->
		<div>
			<Header />
			<Main />
		</div>

module.exports = Home