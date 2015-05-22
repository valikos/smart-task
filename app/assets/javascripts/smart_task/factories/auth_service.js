(function(){
  AuthService = function($http, $q, $rootScope, AuthToken, AuthEvents) {
    return {
      signIn: function(credentials) {
        var d = $q.defer();
        $http.post('/sign_in', {
          email: credentials.email,
          password: credentials.password
        }).success(function(resp) {
          AuthToken.set(resp.auth_token);
          $rootScope.$broadcast(AuthEvents.loginSuccess);
          d.resolve(resp.user);
        }).error(function(resp) {
          $rootScope.$broadcast(AuthEvents.loginFailed);
          d.reject(resp.error);
        });
        return d.promise;
      },
      signUp: function(credentials) {
        var d = $q.defer();
        $http.post('/sign_up', {
          email: credentials.email,
          password: credentials.password
        }).success(function(resp) {
          AuthToken.set(resp.auth_token);
          $rootScope.$broadcast(AuthEvents.loginSuccess);
          d.resolve(resp.user);
        }).error(function(resp) {
          $rootScope.$broadcast(AuthEvents.loginFailed);
          d.reject(resp.error);
        });
        return d.promise;
      }
    };
  };
  angular.module('SmartTask').factory("AuthService", [
    '$http', '$q', '$rootScope', 'AuthToken', 'AuthEvents', AuthService
  ]);
})();