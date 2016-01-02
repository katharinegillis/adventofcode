React          = require 'react'
ReactPropTypes = React.PropTypes

class Error extends React.Component
	@propTypes:
		message: ReactPropTypes.string.isRequired

	render: ->
		<div className="error">
			<p>{@props.message}</p>
		</div>

module.exports = Error