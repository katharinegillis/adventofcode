React = require 'react'

class App extends React.Component
  render: ->
    <div>
      {this.props.children}
    </div>

module.exports = App