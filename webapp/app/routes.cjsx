React      = require 'react'
Route      = require('react-router').Route
IndexRoute = require('react-router').IndexRoute
App        = require './components/App.cjsx'
Home       = require './components/Home/Home.cjsx'
Day        = require './components/Day/Day.cjsx'
Code       = require './components/Code/Code.cjsx'

module.exports =
	<Route path='/' component={App}>
		<IndexRoute component={Home} />
		<Route path='day/:dayId' component={Day} />
		<Route path='code/:dayId/:puzzleId' component={Code} />
	</Route>