(function(){
  TaskCtrl = function($scope, $modal, Task) {
    $scope.newTask = {};
    $scope.originalTask = null;
    $scope.editedTask = null;

    $scope.draggable = {
      accept: function(sourceNodeScope, destNodesScope, destIndex) {
        if(destNodesScope.isParent(sourceNodeScope)){
          return true;
        }
        return false;
      },
      dropped: function(event, q,w,e,r) {
        var newOrder = [];
        angular.forEach($scope.project.tasks, function(value, key) {
          this.push(value.id);
        }, newOrder);
        Task.reorder_position({project_id: $scope.project.id, tasks: newOrder});
      }
    };

    $scope.addTask = function(project) {
      var tasks = $scope.project.tasks;
      $scope.newTask.project_id = project;
      $scope.newTask.name = $scope.newTask.name;
      Task.save($scope.newTask).$promise
        .then(function(newTask){
          tasks.push(newTask);
        });
      $scope.newTask = {};
    };

    $scope.editTask = function(task) {
      $scope.editedTask = task;
      $scope.originalTask = angular.extend({}, task);

      var modalInstance = $modal.open({
        animation: true,
        backdrop: 'static',
        templateUrl: 'modal/name_edit.html',
        controller: 'ModalEditNameCtrl',
        resolve: {
          items: function() {
            return {
              item: $scope.editedTask,
              contentTitle: 'Task'
            };
          }
        }
      });

      modalInstance.result
        .then(function(taskToUpdate) {
          $scope.updateTask(taskToUpdate);
        }).catch(function(taskToUpdate){
          $scope.cancelEdit(taskToUpdate);
        });
    };

    $scope.cancelEdit = function(task) {
      var tasks = $scope.project.tasks;
      tasks[tasks.indexOf(task)] = $scope.originalProject;
      $scope.originalProject = $scope.editedProject = null;
      angular.element('#modal-for-task-' + project.id).modal('hide');
    };

    $scope.updateTask = function(task) {
      Task.update(task).$promise
        .then(function(result){
          $scope.originalProject = $scope.editedProject = null;
        });
    };

    $scope.removeTask = function(task) {
      var tasks = $scope.project.tasks;
      Task.delete(task).$promise
        .then(function(result){
          tasks.splice(tasks.indexOf(task.id), 1);
        });
    };
  };
  angular.module('SmartTask')
    .controller('TaskCtrl', ['$scope', '$modal', 'Task', TaskCtrl]);
})();