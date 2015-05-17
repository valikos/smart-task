(function(){
  var app = angular.module('SmartTask', ['ngResource', 'ngRoute', 'templates', 'ui.bootstrap']);

  app.config([
    '$httpProvider', function($httpProvider){
      return $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
    }
  ]);

  app.config(['$resourceProvider', function($resourceProvider){
    $resourceProvider.defaults.stripTrailingSlashes = false;
  }]);

  app.config(function($routeProvider){
    var routeConfig = {
      controller: 'ProjectCtrl',
      templateUrl: 'project/index.html'
    };

    $routeProvider
      .when('/', routeConfig)
      .otherwise({
        redirectTo: '/'
      });
  });
})();