React = require 'react'
ReactDOM = require 'react-dom'
Router = require 'react-router'

React.initializeTouchEvents true

routes = require './router'

if process.env.NON_ROOT isnt 'true' and window.location? and window.location.hash isnt ""
  window.location.pathname = window.location.hash.slice(1)

location = if process.env.NON_ROOT == "true"
    null
  else
    Router.HistoryLocation

router = Router.create {location, routes}

router.run (Handler, handlerProps) ->
  window.dispatchEvent new CustomEvent 'locationchange'
  ReactDOM.render(<Handler {...handlerProps} />, document.getElementById("panoptes-main-container"));

logDeployedCommit = require './lib/log-deployed-commit'
logDeployedCommit()
