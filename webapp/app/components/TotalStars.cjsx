React = require 'react'
ReactPropTypes = React.PropTypes

class TotalStars extends React.Component
	@propTypes:
		totalStars: ReactPropTypes.number.isRequired

	render: ->
		<span className="star-count">{@props.totalStars}*</span>

module.exports = TotalStars