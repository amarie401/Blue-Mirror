(function(ng, currentUser) {
  ng.module('BlueMirrorApp').service('UserService', function() {

      let currentUser = window.currentUser;

      function getUser() {
          return currentUser;
      }

      return {
          currentUser: currentUser,
          getUser: getUser,

      };
  });

})(angular, window.currentUser);
