(function(){
  AttachmentCtrl = function($scope, Upload, Attachment) {
    $scope.attachments = null;
    $scope.$watch("testInput", function(){
      $scope.attachments = $scope.loadAttachments();
    });

    $scope.$watch('files', function() {
      $scope.upload($scope.files);
    });

    $scope.loadAttachments = function() {
      Attachment.query({
        project_id: $scope.task.project_id,
        task_id: $scope.task.id
      }).$promise
      .then(function(respond){
        $scope.attachments = respond;
      });
    };

    $scope.upload = function (files) {
      if (files && files.length) {
        for (var i = 0; i < files.length; i++) {
          var file = files[i];
          Upload.upload({
            url: '/attachments/upload',
            fields: {'task_id': $scope.task.id},
            method: 'POST',
            file: file
          }).progress(function(evt) {
            var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
            console.log('progress: ' + progressPercentage + '% ' + evt.config.file.name);
          }).success(function(data, status, headers, config) {
            $scope.attachments.push(data);
            console.log('file ' + config.file.name + 'uploaded. Response: ' + data);
          });
        }
      }
    };
  };

  angular.module('SmartTask').controller('AttachmentCtrl', ['$scope', 'Upload', 'Attachment', AttachmentCtrl]);
})();