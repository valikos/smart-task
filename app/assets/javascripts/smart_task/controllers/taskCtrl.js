(function(){
  TaskCtrl = function($scope, $filter, $modal, Task) {
    $scope.newTask = {};
    $scope.originalTask = null;
    $scope.editedTask = null;

    $scope.picker = {
      dueDate: null
    };

    $scope.openPicker = function(task) {
      task.setDueDate = true;
    };

    $scope.setDueDate = function(task){
      $scope.updateTask(task);
    };

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
          value.position = key + 1;
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
        }).catch(function(res){
          $scope.$emit('error', res);
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
      tasks[tasks.indexOf(task)] = $scope.originalTask;
      $scope.originalTask = $scope.editedTask = null;
    };

    $scope.updateTask = function(task) {
      Task.update(task).$promise
        .then(function(result){
          $scope.originalProject = $scope.editedProject = null;
        });
    };

    $scope.removeTask = function(idx) {
      var task = $scope.project.tasks[idx];
      Task.delete(task).$promise
        .then(function(result){
          $scope.project.tasks.splice(idx, 1);
        });
    };

    $scope.commentsModal = function(task) {
      var modalInstance = $modal.open({
        animation: true,
        templateUrl: 'modal/comments.html',
        controller: 'CommentsCtrl',
        windowClass: 'modal-comments',
        resolve: {
          items: function() {
            return {
              task: task,
              project: $scope.project
            };
          }
        }
      });
    };
  };

  angular.module('SmartTask')
    .controller('TaskCtrl', ['$scope', '$filter', '$modal', 'Task', TaskCtrl]);
})();