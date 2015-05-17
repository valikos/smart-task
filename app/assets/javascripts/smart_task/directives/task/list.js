(function(){
  taskList = function(){
    return {
      restrict: 'E',
      templateUrl: 'task/index.html',
      controller: 'TaskCtrl'
    };
  };

  angular.module('SmartTask').directive('taskList', taskList);
})();