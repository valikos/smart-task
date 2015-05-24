(function(){
  var AuthToken = function($window) {
    var store = $window.localStorage;
    var key = 'auth-token';

    return {
      get: get,
      set: set,
      remove: remove
    };

    function get() {
      return store.getItem(key);
    }

    function set(token) {
      if (token) {
        return store.setItem(key, token);
      } else {
        return store.removeItem(key);
      }
    }

    function remove() {
      return store.removeItem(key);
    }
  };

  angular.module('SmartTask').factory('AuthToken', ['$window', AuthToken]);
})();