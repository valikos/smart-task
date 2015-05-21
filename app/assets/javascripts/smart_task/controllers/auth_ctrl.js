(function(){
  AuthCtrl = function($scope, AuthService) {
    var ctrl = this;
    $scope.credentials = {};

    $scope.test = function(){
      console.log('click');
    };

    $scope.signIn = function() {
      AuthService.signIn($scope.credentials);
    };

    $scope.signUp = function() {
      AuthService.signUp($scope.credentials);
    };
  };

  angular.module('SmartTask').controller('AuthCtrl', ['$scope', 'AuthService', AuthCtrl]);
})();