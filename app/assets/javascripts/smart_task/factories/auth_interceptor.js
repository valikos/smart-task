(function(){
  var AuthInterceptor = function($q, $injector){
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
        var signUpPage = response.config.url.match(new RegExp('/sign_up'));

        if (response.status === 401 || response.status === 403 || response.status === 419) {
          AuthToken.remove();
          var backUrl = '/sign_in';

          if (response.config.url.match(new RegExp('/sign_up'))) {
            backUrl = '/sign_up';
          }

          $injector.get('$rootScope').$broadcast({
            401: AuthEvents.notAuthenticated,
            403: AuthEvents.notAuthorized,
            419: AuthEvents.sessionTimeout
          }[response.status], {response: response, backUrl: backUrl});
        }
        return $q.reject(response);
      }
    };
  };
  angular.module('SmartTask').factory("AuthInterceptor",  AuthInterceptor);
})();