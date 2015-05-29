(function(){
  var app = angular.module('SmartTask', [
    'ui.router',
    'templates',
    'ngResource',
    'ui.bootstrap',
    'ui.tree',
    'ngFileUpload',
    'flash',
    'ngFacebook'
  ]);

  app.constant('AuthEvents', {
    notAuthenticated: 'notAuthenticated',
    notAuthorized: 'notAuthorized',
    sessionTimeout: 'sessionTimeout',
    loginSuccess: 'loginSuccess',
    loginFailed: 'loginFailed'
  });

  app.run( function( $rootScope ) {
    // Load the facebook SDK asynchronously
    (function(){
       // If we've already installed the SDK, we're done
       if (document.getElementById('facebook-jssdk')) {return;}

       // Get the first script element, which we'll use to find the parent node
       var firstScriptElement = document.getElementsByTagName('script')[0];

       // Create a new script element and set its id
       var facebookJS = document.createElement('script');
       facebookJS.id = 'facebook-jssdk';

       // Set the new script's source to the source of the Facebook JS SDK
       facebookJS.src = '//connect.facebook.net/en_US/all.js';

       // Insert the Facebook JS SDK into the DOM
       firstScriptElement.parentNode.insertBefore(facebookJS, firstScriptElement);
     }());
  });

  app.config( function( $facebookProvider ) {
    $facebookProvider.setAppId('1576845662588924');
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

  app.config(function($stateProvider, $urlRouterProvider){
    $urlRouterProvider.otherwise("/");

    $stateProvider
      .state('index', {
        url: '/',
        controller: 'ProjectCtrl',
        templateUrl: 'project/index.html'
      })
      .state('sign_in', {
        url: '/sign_in',
        controller:  'AuthCtrl',
        templateUrl: 'auth/sign_in.html'
      })
      .state('sign_up', {
        url: '/sign_up',
        controller:  'AuthCtrl',
        templateUrl: 'auth/sign_up.html'
      });
  });
})();
