var combineReducers = require('redux').combineReducers;
var applyMiddleware = require('redux').applyMiddleware;
var thunk = require('redux-thunk');
var createLogger = require('redux-logger');
var createStore = require('redux').createStore;

var logger = createLogger();

var reducer = combineReducers({
  projects: require('./reducers/projects'),
  tutorials: require('./reducers/tutorials')
});

module.exports = applyMiddleware(thunk, logger)(createStore)(reducer);
window.zooStore = module.exports
