React                = require 'react'
Router               = require('react-router').Router
ReactDOM             = require 'react-dom'
hashHistory          = require('react-router').hashHistory
routes               = require './routes.cjsx'

ReactDOM.render(<Router history={hashHistory}>{routes}</Router>, document.getElementById('app'))