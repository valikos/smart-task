AuthService = ($http, $q, $rootScope, AuthToken, AuthEvents) ->
  signIn = (credentials) ->
    d = $q.defer()
    $http
      .post('/sign_in', {
        email: credentials.email
        password: credentials.password
      })
      .success((resp) ->
        AuthToken.set(resp.auth_token)
        $rootScope.$broadcast(AuthEvents.loginSuccess)
        d.resolve(resp.user)
      )
      .error((resp) ->
        $rootScope.$broadcast(AuthEvents.loginFailed)
        d.reject(resp.error)
      )
    d.promise

  signUp = (credentials) ->
    d = $q.defer()
    $http
      .post('/sign_up', {
        email: credentials.email
        password: credentials.password
      })
      .success((resp) ->
        AuthToken.set(resp.auth_token)
        $rootScope.$broadcast(AuthEvents.loginSuccess)
        d.resolve(resp.user)
      )
      .error((resp) ->
        $rootScope.$broadcast(AuthEvents.loginFailed)
        d.reject(resp.error)
      )
    d.promise

  facebookSignIn = (oauth) ->
    d = $q.defer()
    $http
      .post('/auth/facebook', {
        oauth: oauth,
      })
      .success((resp) ->
        AuthToken.set(resp.auth_token)
        $rootScope.$broadcast(AuthEvents.loginSuccess)
        d.resolve(resp.user)
      )
      .error((resp) ->
        $rootScope.$broadcast(AuthEvents.loginFailed)
        d.reject(resp.error)
      )
    d.promise

  return {
    signIn: signIn
    signUp: signUp
    facebookSignIn: facebookSignIn
  }

angular
  .module('SmartTask')
  .factory("AuthService", [
    '$http'
    '$q'
    '$rootScope'
    'AuthToken'
    'AuthEvents'
    AuthService
  ])