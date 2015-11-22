DEFAULT_ENV = 'cientopolis'

API_HOSTS =
  cientopolis: 'http://192.168.0.109:3000'

API_APPLICATION_IDS =
  cientopolis: '5c23b6bffa9e6eee20f7cefae99c3a88bde762e88106956381cd9f268c59bec5'

TALK_HOSTS =
  cientopolis: 'http://192.168.0.109:3000'

SUGAR_HOSTS =
  cientopolis: 'http://192.168.0.109:3000'

hostFromBrowser = location?.search.match(/\W?panoptes-api-host=([^&]+)/)?[1]
appFromBrowser = location?.search.match(/\W?panoptes-api-application=([^&]+)/)?[1]
talkFromBrowser = location?.search.match(/\W?talk-host=([^&]+)/)?[1]
sugarFromBrowser = location?.search.match(/\W?sugar-host=([^&]+)/)?[1]

hostFromShell = process.env.PANOPTES_API_HOST
appFromShell = process.env.PANOPTES_API_APPLICATION
talkFromShell = process.env.TALK_HOST
sugarFromShell = process.env.SUGAR_HOST

envFromBrowser = location?.search.match(/\W?env=(\w+)/)?[1]
envFromShell = process.env.NODE_ENV

env = envFromBrowser ? envFromShell ? DEFAULT_ENV

module.exports =
  host: hostFromBrowser ? hostFromShell ? API_HOSTS[env]
  clientAppID: appFromBrowser ? appFromShell ? API_APPLICATION_IDS[env]
  talkHost: talkFromBrowser ? talkFromShell ? TALK_HOSTS[env]
  sugarHost: sugarFromBrowser ? sugarFromShell ? SUGAR_HOSTS[env]
