(function(){
  ProjectCtrl = function($scope, $modal, Project) {
    var projects = $scope.projects = Project.query();
    $scope.newProject = {};
    $scope.editedProject = null;

    $scope.addProject = function(newProject) {
      Project.save(newProject).$promise
        .then(function(project) {
          $scope.projects.push(project);
        });
      $scope.newProject = {};
      angular.element('#add-project').modal('hide');
    };

    $scope.editProject = function(project) {
      $scope.editedProject = project;
      $scope.originalProject = angular.extend({}, project);

      var modalInstance = $modal.open({
        animation: true,
        backdrop: 'static',
        templateUrl: 'modal/name_edit.html',
        controller: 'ModalEditNameCtrl',
        resolve: {
          items: function () {
            return {
              item: $scope.editedProject,
              contentTitle: 'Project'
            };
          }
        }
      });

      modalInstance.result
        .then(function(projectToUpdate) {
          $scope.updateProject(projectToUpdate);
        }).catch(function(projectToUpdate){
          $scope.cancelEdit(projectToUpdate);
        });
    };

    $scope.cancelEdit = function(project) {
      $scope.projects[$scope.projects.indexOf(project)] = $scope.originalProject;
      $scope.originalProject = $scope.editedProject = null;
    };

    $scope.updateProject = function(project) {
      Project.update(project).$promise
        .then(function(result){
          $scope.originalProject = $scope.editedProject = null;
        });
    };

    $scope.removeProject = function(idx) {
      var project = $scope.projects[idx];
      Project.delete(project).$promise
        .then(function(result){
          $scope.projects.splice(idx, 1);
        });
    };

    $scope.cancelNewProject = function(){
      $scope.newProject = {};
      angular.element('#add-project').modal('hide');
    };
  };

  angular.module('SmartTask')
    .controller('ProjectCtrl', ['$scope', '$modal', 'Project', ProjectCtrl]);
})();