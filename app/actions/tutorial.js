var apiClient = require('../api/client');
var putFile = require('../lib/put-file');

var tutorialActions = {
  createForProject: function(projectID) {
    return function(dispatch) {
      var tutorialData = {
        steps: [],
        language: 'en',
        links: {
          project: projectID
        }
      };
      return apiClient.type('tutorials').create(tutorialData).save()
        .then(function() {
          return dispatch(tutorialActions.getByProject(projectID));
        });
    };
  },

  delete: function(tutorialID) {
    return function(dispatch) {
      dispatch({
        type: 'DELETE_TUTORIAL',
        tutorialID: tutorialID
      });
      return apiClient.type('tutorials').get(tutorialID)
        .then(function(tutorial) {
          return tutorial.delete();
        });
    }
  },

  getByProject: function(projectID) {
    return function(dispatch) {
      return apiClient.type('tutorials').get({
        project_id: projectID
      })
      .then(function(tutorials) {
        return tutorials[0];
      })
      .then(function(tutorial) {
        if (tutorial) {
          dispatch({
            type: 'RECEIVE_TUTORIAL',
            projectID: projectID,
            tutorial: tutorial
          });
        } else {
          // TODO: How should we define the difference between a nonexistant tutorial
          // and one that hasn't been fetched yet? Is it null vs undefined?
        }
      });
    }
  },

  getMedia: function(tutorialID) {
    return function(dispatch) {
      return apiClient.type('tutorials').get(tutorialID)
        .then(function(tutorial) {
          return tutorial.get('attached_images', {});
        })
        .catch(function() {
          return [];
        })
        .then(function(mediaResources) {
          return mediaResources.reduce(function(mappedByID, resource) {
            mappedByID[resource.id] = resource;
            return mappedByID;
          }, {});
        })
        .then(function(mediaByID) {
          dispatch({
            type: 'RECEIVE_MEDIA_FOR_TUTORIAL',
            tutorialID: tutorialID,
            media: mediaByID
          });
        });
    };
  },

  appendStep: function(tutorialID) {
    return function(dispatch, getState) {
      dispatch({
        type: 'APPEND_TUTORIAL_STEP',
        tutorialID: tutorialID
      });
      return apiClient.type('tutorials').get(tutorialID)
        .then(function(tutorial) {
          return tutorial.update({
            steps: getState().tutorials[tutorialID].steps
          }).save();
        });
    };
  },

  removeStep: function(tutorialID, stepIndex) {
    return function(dispatch, getState) {
      dispatch({
        type: 'REMOVE_TUTORIAL_STEP',
        tutorialID: tutorialID,
        stepIndex: stepIndex
      });
      return apiClient.type('tutorials').get(tutorialID)
        .then(function(tutorial) {
          return tutorial.update({
            steps: getState().tutorials[tutorialID].steps
          }).save();
        });
    };
  },

  setStepMedia: function(tutorialID, stepIndex, file) {
    return function(dispatch) {
      dispatch({
        type: 'SET_TUTORIAL_STEP_MEDIA',
        tutorialID: tutorialID,
        stepIndex: stepIndex,
        mediaID: null
      });
      apiClient.type('tutorials').get(tutorialID)
        .then(function(tutorial) {
          var changes = {};
          if (file) {
            var mediaPayload = {
              media: {
                content_type: file.type,
                metadata: {
                  filename: file.name
                }
              }
            };
            return apiClient.post(tutorial._getURL('attached_images'), mediaPayload)
              .then(function(media) {
                return [].concat(media)[0];
              })
              .then(function(media) {
                return putFile(media.src, file)
                  .then(function() {
                    dispatch({
                      type: 'SET_TUTORIAL_STEP_MEDIA',
                      tutorialID: tutorialID,
                      stepIndex: stepIndex,
                      mediaID: media.id
                    });
                    changes['steps.' + stepIndex + '.media'] = media.id;
                    return tutorial.update(changes).save();
                  });
              });
          } else {
            changes['steps.' + stepIndex + '.media'] = '';
            return tutorial.update(changes).save();
          }
        })
        .then(function() {
          dispatch(tutorialActions.getMedia(tutorialID));
        });
    };
  },

  setStepContent: function(tutorialID, stepIndex, content) {
    return function(dispatch) {
      dispatch({
        type: 'SET_TUTORIAL_STEP_CONTENT',
        tutorialID: tutorialID,
        stepIndex: stepIndex,
        content: content
      });
      // TODO: Debounce this.
      return apiClient.type('tutorials').get(tutorialID)
        .then(function(tutorial) {
          var changes = {};
          changes['steps.' + stepIndex + '.content'] = content;
          return tutorial.update(changes).save();
        });
    };
  }
};

module.exports = tutorialActions;
