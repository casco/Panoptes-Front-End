Router = {IndexRoute, Route} = require 'react-router'
React = require 'react'

module.exports =
<Route component={require './partials/app'}>
  <IndexRoute name="home" component={require './pages/home'} />

  <Route name="about" path="about/?" component={require './pages/about'} ignoreScrollBehavior>
    <IndexRoute name="about-home" component={require './pages/about/about-home'} />
    <Route name="about-team" path="team/?" component={require './pages/about/team-page'} />
    <Route name="about-publications" path="publications/?" component={require './pages/about/publications-page'} />
    <Route name="about-education" path="education/?" component={require './pages/about/education-page'} />
    <Route name="about-contact" path="contact/?" component={require './pages/about/contact-page'} />
  </Route>

  <Route name="reset-password" path="reset-password/?" component={require './pages/reset-password'} />

  <Route name="unsubscribe" path="unsubscribe/?" component={require './pages/unsubscribe'} />

  <Route path="accounts" component={require './pages/sign-in'}>
    <Route name="sign-in" path="sign-in/?" component={require './partials/sign-in-form'} />
    <Route name="register" path="register/?" component={require './partials/register-form'} />
  </Route>
  <Route name="privacy" path="privacy/?" component={require './pages/privacy-policy'} />

  <Route path="users/:name/?" component={require './pages/profile'}>
    <IndexRoute name="user-profile" component={require './pages/profile/feed'} />
    <Route name="user-profile-private-message" path="message/?" component={require './pages/profile/private-message'} />
    <Route name="user-profile-stats" path="stats/?" component={require './pages/profile/stats'} />
  </Route>

  <Route name="inbox" path="inbox/?" component={require './talk/inbox'} />
  <Route name="inbox-conversation" path="inbox/:conversation/?" component={require './talk/inbox-conversation'} />

  <Route path="settings/?" component={require './pages/settings'}>
    <IndexRoute name="settings" component={require './pages/settings/account'} />
    <Route name="profile-settings" path="profile/?" component={require './pages/settings/profile' } />
    <Route name="email-settings" path="email/?" component={require './pages/settings/email' } />
  </Route>

  <Route name="projects" path="projects/?" component={require './pages/projects'} />
  <Route path="projects/:owner/:name/?" component={require './pages/project'}>
    <IndexRoute name="project-home" component={require './pages/project/home'} />
    <Route name="project-research" path="research/?" component={require './pages/project/research'} />
    <Route name="project-results" path="results/?" component={require './pages/project/results'} />
    <Route name="project-classify" path="classify/?" component={require './pages/project/classify'} />
    <Route name="project-notifications" path="notifications/?" component={require './pages/notifications'} />
    <Route name="project-talk" path="talk/?" component={require './pages/project/talk'}>
      <IndexRoute name="project-talk-home" component={require './talk/init'} />
      <Route name="project-talk-recents" path="recents/?" component={require './talk/recents'} />
      <Route name="project-talk-not-found" path="not-found/?" component={require './pages/not-found'} />
      <Route name="project-talk-search" path="search/?" component={require './talk/search'}/>
      <Route name="project-talk-moderations" path="moderations/?" component={require './talk/moderations'}/>
      <Route name="project-talk-subject" path="subjects/:id/?" component={require './subjects'}/>
      <Route name="project-talk-board-recents" path="recents/:board/?" component={require './talk/recents'} />
      <Route name="project-talk-tags" path="tags/:tag/?" component={require './talk/tags'} />
      <Route name="project-talk-board" path=":board/?" component={require './talk/board'} />
      <Route name="project-talk-discussion" path=":board/:discussion/?" component={require './talk/discussion'} />
    </Route>
    <Route name="project-faq" path="faq/?" component={require './pages/project/faq'} />
    <Route name="project-education" path="education/?" component={require './pages/project/education'} />
  </Route>

  <Route name="notifications" path="notifications/?" component={require './pages/notifications'} />
  <Route name="section-notifications" path=":section/notifications/?" component={require './pages/notifications'} />

  <Route name="talk" path="talk/?" component={require './talk'}>
    <IndexRoute name="talk-home" component={require './talk/init'} />
    <Route name="talk-recents" path="recents/?" component={require './talk/recents'} />
    <Route name="talk-not-found" path="not-found/?" component={require './pages/not-found'} />
    <Route name="talk-search" path="search/?" component={require './talk/search'} />
    <Route name="talk-moderations" path="moderations/?" component={require './talk/moderations'} />
    <Route name="talk-board" path=":board/?" component={require './talk/board'} />
    <Route name="talk-board-recents" path="recents/:board/?" component={require './talk/recents'} />
    <Route name="talk-discussion" path=":board/:discussion/?" component={require './talk/discussion'} />
  </Route>

  <Route name="favorites" path="favorites/?" component={require('./pages/collections').FavoritesList}>
    <Route name="favorites-user" path=":owner/?" component={require('./pages/collections').FavoritesList} />
  </Route>

  <Route name="collections" path="collections/?" component={require('./pages/collections').CollectionsList}>
    <Route name="collections-user" path=":owner/?" component={require('./pages/collections').CollectionsList} />
  </Route>
  <Route name="collection-show" path="collections/:owner/:name/?" component={require './collections/show'}>
    <IndexRoute name="collection-show-list" component={require './collections/show-list'} />
    <Route name="collection-settings" path="settings/?" component={require './collections/settings'} />
    <Route name="collection-collaborators" path="collaborators/?" component={require './collections/collaborators'} />
    <Route name="collection-talk" path="talk/?" component={require './collections/show-list'} />
  </Route>

  <Route name="lab" path="lab/?" component={require './pages/lab'} />
  <Route path="lab/:projectID/?" component={require './pages/lab/project'}>
    <IndexRoute name="edit-project-details" component={require './pages/lab/project-details'} />
    <Route name="edit-project-research" path="research/?" component={require './pages/lab/research'} />
    <Route name="edit-project-results" path="results/?" component={require './pages/lab/results'} />
    <Route name="edit-project-faq" path="faq/?" component={require './pages/lab/faq'} />
    <Route name="edit-project-education" path="education/?" component={require './pages/lab/education'} />
    <Route name="edit-project-collaborators" path="collaborators/?" component={require './pages/lab/collaborators'} />
    <Route name="edit-project-media" path="media/?" component={require './pages/lab/media'} />
    <Route name="edit-project-workflow" path="workflow/:workflowID/?" component={require './pages/lab/workflow'} />
    <Route name="edit-project-subject-set" path="subject-set/:subjectSetID/?" component={require './pages/lab/subject-set'} />
    <Route name="edit-project-visibility" path="visibility/?" component={require './pages/lab/visibility'} />
    <Route name="edit-project-talk" path="talk/?" component={require './pages/lab/talk'} />
    <Route name="get-data-exports" path="data-exports" component={require './pages/lab/data-dumps'} />
    <Route name="edit-project-tutorial" path="tutorial" component={require './pages/lab/tutorial'} />
  </Route>
  <Route name="lab-policies" path="lab-policies/?" component={require './pages/lab/lab-policies'} />
  <Route name="lab-how-to" path="lab-how-to/?" component={require './pages/lab/how-to-page'} />

  <Route name="admin" path="admin/?" component={require './pages/admin'}>
    <IndexRoute name="admin-user-search" component={require './pages/admin/user-settings'} />
    <Route name="admin-project-list" path="project_status/?" component={require './pages/admin/project-status-list'} />
    <Route name="admin-project-status" path="project_status/:owner/:name/?" component={require './pages/admin/project-status'} />
  </Route>

  <Route path="todo/?*" component={React.createClass render: -> <div className="content-container"><i className="fa fa-cogs"></i> TODO</div>} />
  # <NotFoundRoute component={require './pages/not-found'} />

  <Route path="dev/workflow-tasks-editor" component={require './components/workflow-tasks-editor'} />
  <Route path="dev/classifier" component={require './classifier'} />
  <Route path="dev/aggregate" component={require './components/aggregate-view'} />
  <Route path="dev/ribbon" component={require './components/classifications-ribbon'} />
</Route>
