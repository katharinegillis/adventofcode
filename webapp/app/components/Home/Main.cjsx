React = require 'react'
Tree  = require './Tree.cjsx'

class Main extends React.Component
	render: ->
		<main>
			<p>Pick a day from the advent calendar:</p>
			<Tree />
		</main>

module.exports = Main