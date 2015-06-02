(function(){
  var AuthCtrl = function($scope, $location, $facebook, AuthService, AuthToken) {
    var ctrl = this;
    $scope.credentials = {};

    $scope.signIn = function() {
      AuthService.signIn($scope.credentials)
        .then(function(){
          $location.path('/');
        }).catch(function(res){
          $scope.$emit('error', res);
        });
    };

    $scope.signUp = function() {
      AuthService.signUp($scope.credentials)
        .then(function(){
          $location.path('/');
        }).catch(function(res){
          $scope.$emit('error', res);
        });
    };

    $scope.signOut = function() {
      $facebook.logout();
      AuthToken.remove();
      $location.path('/sign_in');
    };

    $scope.fbSignIn = function(){
      $facebook.login().then(function() {
        refresh();
      });
    };

    function refresh() {
      $facebook.api("/me").then(
        function(response) {
          $scope.welcomeMsg = "Welcome " + response.name;
          $scope.isLoggedIn = true;
        },
        function(err) {
          $scope.welcomeMsg = "Please log in";
        }
      );
    }
  };

  angular.module('SmartTask').controller('AuthCtrl', [
    '$scope',
    '$location',
    '$facebook',
    'AuthService',
    'AuthToken',
    AuthCtrl
  ]);
})();