AuthToken = ($window) ->

  store = $window.localStorage
  key = 'auth-token'

  get = () ->
    store.getItem(key)

  set = (token) ->
    if token
      return store.setItem(key, token)
    else
      return store.removeItem(key)

  remove = () ->
    store.removeItem(key)

  return {
    get: get
    set: set
    remove: remove
  }

angular
  .module('SmartTask')
  .service('AuthToken', [
    '$window'
    AuthToken
  ])