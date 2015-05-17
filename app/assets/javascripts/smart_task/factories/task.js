(function(){
  Task = function($resource){
    return $resource(
      "/projects/:project_id/tasks/:listController:id",
      {
        id: '@id',
        project_id: '@project_id',
        listController: '@listController',
        list: '@list'
      },
      {
        update: { method: 'PUT' },
        reorder_position: {
          method: 'POST',
          params: {
            listController: 'reorder_position'
          },
          isArray: true
        }
      }
    );
  };
  angular.module('SmartTask').factory('Task', Task);
})();