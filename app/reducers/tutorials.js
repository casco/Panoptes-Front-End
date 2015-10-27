function getDefaultStep() {
  return {
    media: '',
    content: ''
  };
};

module.exports = function(state, action) {
  if (state === undefined) {
    return {
      byProject: {},
      media: {}
    };
  }

  var newState = Object.assign({}, state);

  switch (action.type) {
    case 'RECEIVE_TUTORIAL':
      newState[action.tutorial.id] = action.tutorial;
      newState.byProject = Object.assign({}, newState.byProject);
      newState.byProject[action.projectID] = action.tutorial.id;
      return newState;

    case 'DELETE_TUTORIAL':
      delete newState[action.tutorialID];
      return newState;

    case 'RECEIVE_MEDIA_FOR_TUTORIAL':
      newState.media = Object.assign({}, state.media);
      newState.media[action.tutorialID] = action.media;
      return newState;

    case 'APPEND_TUTORIAL_STEP':
      newState[action.tutorialID] = Object.assign({}, state[action.tutorialID]);
      newState[action.tutorialID].steps = [].concat(state[action.tutorialID].steps);
      var newStep = Object.assign({}, getDefaultStep());
      newState[action.tutorialID].steps.push(newStep);
      return newState;

    case 'REMOVE_TUTORIAL_STEP':
      newState[action.tutorialID] = Object.assign({}, state[action.tutorialID]);
      newState[action.tutorialID].steps = [].concat(state[action.tutorialID].steps);
      newState[action.tutorialID].steps.splice(action.index, 1);
      return newState;

    case 'SET_TUTORIAL_STEP_MEDIA':
    newState[action.tutorialID] = Object.assign({}, state[action.tutorialID]);
    newState[action.tutorialID].steps[action.stepIndex].media = action.mediaID;
      return newState;

    case 'SET_TUTORIAL_STEP_CONTENT':
      newState[action.tutorialID] = Object.assign({}, state[action.tutorialID]);
      newState[action.tutorialID].steps[action.stepIndex].content = action.content;
      return newState;

    default:
      return state;
  }
}
