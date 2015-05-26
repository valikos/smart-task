(function(){
  Comment = function($resource){
    return $resource(
      "/projects/:project_id/tasks/:task_id/comments/:id",
      {
        id: '@id',
        project_id: '@project_id',
        task_id: '@task_id'
      }
    );
  };
  angular.module('SmartTask').factory('Comment', Comment);
})();