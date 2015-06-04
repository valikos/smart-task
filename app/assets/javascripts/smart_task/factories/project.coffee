Project = ($resource) ->
  return $resource(
    "/projects/:id"
    { id: '@id' }
    {
      update:
        method: 'PUT'
    }
  )

angular
  .module('SmartTask')
  .factory('Project', Project)
