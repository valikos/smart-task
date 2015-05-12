(function(){ 
  var app = angular.module('smartTask', ['ngResource', 'templates']);

  app.config([
    '$httpProvider', function($httpProvider) {
      return $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
    }
  ]);

  app.config(['$resourceProvider', function($resourceProvider) {
    $resourceProvider.defaults.stripTrailingSlashes = false;
  }]);

  app.factory('Project', function($resource) {
    return $resource("/projects/:id", { id: '@id' }, {
      update: { method: 'PUT' }
    });
  });

  app.controller('ProjectController', ['$http', '$scope', 'Project', function($http, $scope, Project){
    var projects = $scope.projects = Project.query();
    $scope.newProject = {};
    $scope.editedProject = null;

    $scope.addProject = function(newProject) {
      Project.save(newProject).$promise
        .then(function(project) {
          projects.push(project);
        });
      $scope.newProject = {};
      angular.element('#add-project').modal('hide');
    }

    $scope.editProject = function(project) {
      $scope.editedProject = project;
      $scope.originalProject = angular.extend({}, project);
    };

    $scope.cancelEdit = function(project) {
      projects[projects.indexOf(project)] = $scope.originalProject;
      $scope.originalProject = $scope.editedProject = null;
      angular.element('#modal-for-' + project.id).modal('hide');
    }

    $scope.updateProject = function(project) {
      Project.update(project).$promise
        .then(function(result){
          $scope.originalProject = $scope.editedProject = null
        })
      angular.element('#modal-for-' + project.id).modal('hide');
    };

    $scope.removeProject = function(idx) {
      var project = $scope.projects[idx];
      Project.delete(project).$promise
        .then(function(result){
          $scope.projects.splice(idx, 1);
        });
    };
  }]);
})();
