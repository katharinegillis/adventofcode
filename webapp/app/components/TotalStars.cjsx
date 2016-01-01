React = require 'react'

class TotalStars extends React.Component
	constructor: (props) ->
		super props
		@state =
			value: 0

	render: ->
		<span className="star-count">{@state.value}*</span>

module.exports = TotalStars