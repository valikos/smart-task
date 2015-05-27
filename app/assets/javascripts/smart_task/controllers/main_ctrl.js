(function(){
  MainCtrl = function($rootScope, $location, Flash, AuthEvents) {
    $rootScope.$on(AuthEvents.notAuthenticated, function(event, args) {
      $location.path('/sign_in');
    });

    $rootScope.$on(AuthEvents.notAuthorized, function(event, args) {
      $location.path('/sign_in');
    });

    $rootScope.$on(AuthEvents.sessionTimeout, function(event, args) {
      $location.path('/sign_in');
    });

    $rootScope.$on('error', function(event, args){
      Flash.create('danger', args);
    });
  };
  angular.module('SmartTask').controller('MainCtrl', [
    '$rootScope',
    '$location',
    'Flash',
    'AuthEvents',
    MainCtrl
  ]);
})();