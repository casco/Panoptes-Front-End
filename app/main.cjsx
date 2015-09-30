React = require 'react'
Router = require '@edpaget/react-router'

React.initializeTouchEvents true
{Provider} = require 'react-redux'

routes = require './router'
mainContainer = document.createElement 'div'
mainContainer.id = 'panoptes-main-container'
document.body.appendChild mainContainer

store = require './store'

if process.env.NON_ROOT isnt 'true' and location? and location.hash isnt ""
  location.pathname = location.hash.slice(1)

# location = if process.env.NON_ROOT == "true"
#     null
#   else
#     Router.HistoryLocation

Router.run routes, Router.HistoryLocation, (Handler, routerState) =>
  window.dispatchEvent new CustomEvent 'locationchange'
  React.render(
    <Provider store={store}>
      {=> <Handler {...routerState} />}
    </Provider>,
  document.getElementById("panoptes-main-container"))

logDeployedCommit = require './lib/log-deployed-commit'
logDeployedCommit()
