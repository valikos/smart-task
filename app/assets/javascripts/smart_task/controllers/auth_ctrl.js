(function(){
  AuthCtrl = function($scope, $location, AuthService, AuthToken) {
    var ctrl = this;
    $scope.credentials = {};

    $scope.signIn = function() {
      AuthService.signIn($scope.credentials)
        .then(function(){
          $location.path('/');
        });
    };

    $scope.signUp = function() {
      AuthService.signUp($scope.credentials)
        .then(function(){
          $location.path('/');
        });
    };

    $scope.signOut = function() {
      AuthToken.remove();
      $location.path('/sign_in');
    };
  };

  angular.module('SmartTask').controller('AuthCtrl', ['$scope', '$location', 'AuthService', 'AuthToken', AuthCtrl]);
})();