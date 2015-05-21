(function(){
  MainCtrl = function($rootScope, $location, AuthEvents) {
    $rootScope.$on(AuthEvents.notAuthenticated, function(event, args) {
      console.log(event, args);
      $location.path('/sign_in');
    });

    $rootScope.$on(AuthEvents.notAuthorized, function(event, args) {
      console.log(event, args);
      $location.path('/sign_in');
    });

    $rootScope.$on(AuthEvents.sessionTimeout, function(event, args) {
      console.log(event, args);
      $location.path('/sign_in');
    });
  };
  angular.module('SmartTask').controller('MainCtrl', ['$rootScope', '$location', 'AuthEvents', MainCtrl]);
})();