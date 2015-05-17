(function(){
  ModalEditNameCtrl = function($scope, $modalInstance, args) {
    $scope.item = args.item;
    $scope.contentTitle = args.contentTitle;

    $scope.ok = function () {
      $modalInstance.close($scope.item);
    };

    $scope.cancel = function () {
      $modalInstance.dismiss($scope.item);
    };
  };

  angular.module('SmartTask')
    .controller('ModalEditNameCtrl', ['$scope', '$modalInstance', 'items', ModalEditNameCtrl]);
})();