React       = require 'react'
Branch      = require './Branch.cjsx'
TreeStore   = require '../../stores/TreeStore.coffee'
TreeActions = require '../../actions/TreeActions.coffee'

getTreeState = () ->
	return branches: TreeStore.getBranches()

class Tree extends React.Component
	constructor: (props) ->
		super props
		@state = getTreeState()
		@onChange = @onChange.bind this

	componentDidMount: ->
		TreeStore.addChangeListener @onChange
		TreeActions.getBranches()

	componentWillUnmount: ->
		TreeStore.removeChangeListener @onChange

	onChange: ->
		@setState getTreeState()

	render: ->
		if Object.keys(@state.branches).length < 1
			return null

		branches = []
		branches.push <Branch key={key} dayId={branch.day} count={branch.count} /> for branch, key in @state.branches

		<pre className="tree">
			{branches}
			<span className="tree-trunk">                       |   |<br />                       |   |<br />            _  _ __ ___|___|___ __ _  _           </span>
		</pre>

module.exports = Tree