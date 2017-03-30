(function(ng) {
    ng.module('BlueMirrorApp', ['ui.router', 'templates', 'uiGmapgoogle-maps', 'nemLogging', 'ngGeolocation', 'chart.js', 'ui.calendar', 'ui.bootstrap', 'ui.sortable'])

        .config(['uiGmapGoogleMapApiProvider', function(uiGmapGoogleMapApiProviders) {
            uiGmapGoogleMapApiProviders.configure({
                key: 'AIzaSyAp0S6RJ9DAtCo8ODnJffXAu8SIIYGIIP4',
                libraries: 'weather,geometry,visualization,places'
            });
        }]);

    ng.module('BlueMirrorApp').config(function($stateProvider, $locationProvider, $urlRouterProvider) {
        $locationProvider.hashPrefix('!');

        $urlRouterProvider.otherwise('/');
        $urlRouterProvider.when('/', '/' + 'login');

        $stateProvider.state('BlueParent', {
            url: '/',
            abstract: true,
            template: '<ui-view></ui-view>'
        }).state('BlueParent.login', {
            url: 'login',
            templateUrl: 'login-template.html'
        }).state('BlueParent.profile', {
            url: 'profile',
            templateUrl: 'user-profile.html',
            controller: "ProfileController as profile"
        }).state('BlueParent.counselors', {
            url: 'counselors',
            templateUrl: 'map-template.html',
            controller: "MapController as map"
        }).state('BlueParent.place', {
            url: 'place',
            templateUrl: 'place.html',
            controller: "MapController as map"
        }).state('BlueParent.mood', {
            url: 'mood',
            templateUrl: 'chart-template.html',
            controller: "ProfileController as profile"
        }).state('BlueParent.update', {
            url: 'updatemood',
            templateUrl: 'update-mood-template.html',
            controller: "ProfileController as profile"
        }).state('BlueParent.journal', {
            url: 'journal',
            templateUrl: 'journal-template.html',
            controller: "JournalController as journal"
        }).state('BlueParent.todo', {
            url: 'todo',
            templateUrl: 'todo-template.html',
            controller: "ProfileController as profile"
        }).state('BlueParent.meds', {
            url: 'medication',
            templateUrl: 'meds-template.html',
            controller: "MedicineController as meds"
        }).state('BlueParent.customize', {
            url: 'customize',
            templateUrl: 'customize-template.html',
            controller: "ProfileController as profile"
        }).state('BlueParent.hotline', {
            url: 'helpline',
            templateUrl: 'hotline-template.html',
            controller: "ProfileController as profile"
        });

    });

})(angular);
