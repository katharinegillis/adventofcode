React = require 'react'
Route = require('react-router').Route
App   = require './components/App.cjsx'
Home  = require './components/Home.cjsx'

module.exports =
	<Route component={App}>
		<Route path='/' component={Home} />
	</Route>