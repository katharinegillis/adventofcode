React          = require 'react'
ReactPropTypes = React.PropTypes

class Title extends React.Component
	@propTypes:
		title: ReactPropTypes.string.isRequired

	render: ->
		<div className="title">
			<h2>{@props.title}</h2>
		</div>

module.exports = Title