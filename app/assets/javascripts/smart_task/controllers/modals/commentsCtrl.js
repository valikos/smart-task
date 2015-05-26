(function(){
  CommentsCtrl = function($scope, $modalInstance, args, Comment) {
    $scope.task = args.task;
    $scope.newComment = {
      task_id: args.task.id,
      project_id: args.task.project_id
    };

    $scope.comments = args.task.comments;

    $scope.ok = function() {
      $modalInstance.close($scope.item);
    };

    $scope.cancel = function() {
      $modalInstance.dismiss($scope.item);
    };

    $scope.addComment = function() {
      Comment.save($scope.newComment).$promise
        .then(function(newComment){
          $scope.comments.push(newComment);
          delete $scope.newComment.content;
        });
    };

    $scope.removeComment = function(idx) {
      var comment = {
        id: $scope.comments[idx].id,
        task_id: args.task.id,
        project_id: args.project.id
      };
      Comment.delete(comment).$promise
        .then(function(result){
          $scope.comments.splice(idx, 1);
        });
    };
  };

  angular.module('SmartTask')
    .controller('CommentsCtrl', ['$scope', '$modalInstance', 'items', 'Comment', CommentsCtrl]);
})();