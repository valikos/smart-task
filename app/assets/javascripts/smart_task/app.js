(function(){
  var app = angular.module('SmartTask', ['ngResource', 'ngRoute', 'templates', 'ui.bootstrap', 'ui.tree', 'ngFileUpload']);

  app.constant('AuthEvents', {
    notAuthenticated: 'notAuthenticated',
    notAuthorized: 'notAuthorized',
    sessionTimeout: 'sessionTimeout',
    loginSuccess: 'loginSuccess',
    loginFailed: 'loginFailed'
  });

  app.config([
    '$httpProvider', function($httpProvider){
      return $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
    }
  ]);

  app.config(['$resourceProvider', function($resourceProvider){
    $resourceProvider.defaults.stripTrailingSlashes = false;
  }]);

  app.config(function($httpProvider) {
    return $httpProvider.interceptors.push("AuthInterceptor");
  });

  app.config(function($routeProvider){
    var routeConfig = {
      controller: 'ProjectCtrl',
      templateUrl: 'project/index.html'
    };

    $routeProvider
      .when('/', routeConfig)
      .when('/sign_in', {
        controller:  'AuthCtrl',
        controllerAs: 'authCtrl',
        templateUrl: 'auth/sign_in.html'
      })
      .when('/sign_up', {
        controller:  'AuthCtrl',
        controllerAs: 'authCtrl',
        templateUrl: 'auth/sign_up.html'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
})();
