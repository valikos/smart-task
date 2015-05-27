(function(){
  Attachment = function($resource){
    return $resource(
      "/projects/:project_id/tasks/:task_id/attachments",
      {
        project_id: '@project_id',
        task_id: '@task_id'
      }
    );
  };

  angular.module('SmartTask').factory('Attachment', Attachment);
})();