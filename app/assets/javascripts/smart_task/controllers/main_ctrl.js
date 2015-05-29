(function(){
  var MainCtrl = function($rootScope, $location, Flash, AuthEvents) {
    $rootScope.$on(AuthEvents.notAuthenticated, function(event, args) {
      $location.path(args.backUrl);
    });

    $rootScope.$on(AuthEvents.notAuthorized, function(event, args) {
      $location.path(args.backUrl);
    });

    $rootScope.$on(AuthEvents.sessionTimeout, function(event, args) {
      $location.path('/sign_in');
    });

    $rootScope.$on('error', function(event, args){
      var msg = args;
      if (args.data !== undefined) {
        var log = [];

        angular.forEach(args.data, function(value, key) {
          this.push(key + ' ' + value);
        }, log);
        console.log(log);
        msg = log;
      }
      Flash.create('danger', msg);
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