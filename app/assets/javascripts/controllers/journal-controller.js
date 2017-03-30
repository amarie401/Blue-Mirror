(function(ng) {
    ng.module('BlueMirrorApp').controller('JournalController', function($state, $scope, $q, DataRequestService, UserService) {
        $scope.activeEntry = null;
        $scope.viewEntry = null;
        $scope.page = 1;
        $scope.currentUser = UserService.getUser();
        $scope.journalObj = {
            text: '',
            title: 'Untitled',
            tags: ''
        };
        $scope.journalsArray = [];
        $scope.viewEntryArray = [];
        $scope.searchEntryArray = [];
        $scope.addJournals = function() {
            $scope.journalObj.title = $scope.title;
            $scope.journalObj.text = $scope.text;
            $scope.journalObj.tags = $scope.tags;
            $scope.journalObj.day = $scope.day;
            $scope.title = '';
            $scope.tags = '';
            $scope.text = '';
            $scope.error = '';
        };
        $scope.postJournals = function() {
            if ($scope.text === undefined || $scope.text === '') {
                $scope.error = "Please submit your journal entry";
            } else {
                $scope.addJournals();
                $q.when(DataRequestService.postJournal('/notes', $scope.journalObj)).then((response) => {
                    $scope.currentJournal = response.data.location;
                    $scope.journalsArray.push($scope.currentJournal);
                }).catch((error) => {
                    console.log(error);
                });
            }
        };
        $scope.deleteJournalEntry = function(entry) {
            let i = $scope.journalsArray.indexOf(entry);
            $q.when(DataRequestService.delete(`/notes/${$scope.journalsArray[i].id}`)).then((response) => {}).catch((error) => {
                console.log(error);
            });
            $scope.journalsArray.splice(i, 1);
            $scope.activeEntry = null;
        };
        $scope.editJournal = function(entry) {
            $('ul #edit-text, ul #edit-title, ul #edit-tags').addClass('editable');
            if ($('ul #edit-text, ul #edit-title, ul #edit-tags').attr('contenteditable', false)) {
                $('ul #edit-text, ul #edit-title, ul #edit-tags').attr('contenteditable', true);
            }
        };
        $scope.patchJournalText = function(entry) {
            let e = $scope.viewEntryArray[0].id;
            let inputText = document.getElementById('edit-text').innerText;
            let inputTitle = document.getElementById('edit-title').innerText;
            let inputTag = document.getElementById('edit-tags').innerText;
            let i = $scope.journalsArray.indexOf(entry);
            let arrayIndex = $scope.journalsArray[i];
            $q.when(DataRequestService.patchEntry(`/notes/${$scope.viewEntryArray[0].id}`, inputText, inputTitle, inputTag)).then((response) => {

                for (let i = 0; i < $scope.journalsArray.length; i++) {
                    if (arrayIndex.id == e) {
                        arrayIndex.text = response.data.location.text;
                        arrayIndex.title = response.data.location.title;
                        arrayIndex.tag = response.data.location.tag;
                    }
                    arrayIndex.text = response.data.location.text;
                    arrayIndex.title = response.data.location.title;
                    arrayIndex.tag = response.data.location.tag;

                }
                $('ul #edit-text, ul #edit-title, ul #edit-tags').removeClass('editable');
                $('ul #edit-text, ul #edit-title, ul #edit-tags').attr('contenteditable', false);
            }).catch((error) => {
                console.log(error);
            });
        };

        $scope.nextPage = function() {
            $scope.page++;
            $scope.journalsArray = [];
            $q.when(DataRequestService.get(`/notes?page=${$scope.page}`)).then((response) => {
                $scope.pastJournals = response.data;
                let e = $scope.journalsArray.indexOf();
                let arrayIndex = $scope.journalsArray[e];
                for (let entry in $scope.pastJournals) {
                    $scope.pastEntries = $scope.pastJournals[entry];
                    $scope.journalsArray.push($scope.pastEntries);
                }
            }).catch((error) => {
                console.log(error);
            });
        };
        $scope.prevPage = function() {
            $scope.page--;
            $scope.journalsArray = [];
            $q.when(DataRequestService.get(`/notes?page=${$scope.page}`)).then((response) => {
                $scope.pastJournals = response.data;
                let e = $scope.journalsArray.indexOf();
                let arrayIndex = $scope.journalsArray[e];
                for (let entry in $scope.pastJournals) {
                    $scope.pastEntries = $scope.pastJournals[entry];
                    $scope.journalsArray.push($scope.pastEntries);
                }
            }).catch((error) => {
                console.log(error);
            });
        };

        $q.when(DataRequestService.get('/notes')).then((response) => {
            $scope.pastJournals = response.data;
            let e = $scope.journalsArray.indexOf();
            let arrayIndex = $scope.journalsArray[e];
            for (let entry in $scope.pastJournals) {
                $scope.pastEntries = $scope.pastJournals[entry];
                $scope.journalsArray.push($scope.pastEntries);
            }
        }).catch((error) => {
            console.log(error);
        });
        $scope.searchTags = function() {
            $scope.tagInput = document.getElementById('tag-search').value;
            $q.when(DataRequestService.get(`/notes?tag=${$scope.tagInput}`)).then((response) => {
                $scope.journalsArray = [];
                $scope.pastJournals = response.data;
                let e = $scope.journalsArray.indexOf();
                let arrayIndex = $scope.journalsArray[e];
                for (let entry in $scope.pastJournals) {
                    $scope.pastEntries = $scope.pastJournals[entry];
                    $scope.journalsArray.push($scope.pastEntries);
                }
            }).catch((error) => {
                console.log(error);
            });
        };
        $scope.makeActive = function(entry, id) {
            let i = $scope.journalsArray.indexOf(entry);
            $scope.viewEntryArray = [];
            $scope.viewEntry = null;
            $scope.activeEntry = id;
            if ($scope.activeEntry == $scope.journalsArray[i].id) {
                $scope.viewEntry = id;
                $scope.viewEntryArray.push($scope.journalsArray[i]);

            }
        };
    });
})(angular);
