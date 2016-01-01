React                = require 'react'
Router               = require('react-router').Router
ReactDOM             = require 'react-dom'
browserHistory = require('react-router').browserHistory
routes               = require './routes.cjsx'

ReactDOM.render(<Router history={browserHistory}>{routes}</Router>, document.getElementById('app'))