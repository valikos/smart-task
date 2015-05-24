(function(){
  AuthInterceptor = function($q, $injector){
    return {
      request: function(config) {
        var AuthToken = $injector.get("AuthToken");
        var AuthEvents = $injector.get('AuthEvents');
        var token = AuthToken.get();
        config.headers = config.headers || {};
        if (token) {
          config.headers.Authorization = "Bearer " + token;
        }
        return config || $q.when(config);
      },
      responseError: function(response) {
        var AuthEvents = $injector.get('AuthEvents');
        var AuthToken = $injector.get("AuthToken");
        var matchesAuthenticatePath = response.config; // && response.config.url.match(new RegExp('/sign'));
        if (matchesAuthenticatePath) {
          $injector.get('$rootScope').$broadcast({
            401: AuthEvents.notAuthenticated,
            403: AuthEvents.notAuthorized,
            419: AuthEvents.sessionTimeout
          }[response.status], response);
        }
        AuthToken.remove();
        return $q.reject(response);
      }
    };
  };
  angular.module('SmartTask').factory("AuthInterceptor",  AuthInterceptor);
})();