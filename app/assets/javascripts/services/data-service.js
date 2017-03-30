(function(ng, currentUser) {
    ng.module('BlueMirrorApp').service('DataRequestService', AllDataService);

    function AllDataService($http) {
        function getData(url) {
            return $http({
                method: 'GET',
                url: url
            });
        }

        function postData(url, dataObj) {
            return $http({
                method: 'POST',
                url: url,
                dataType: "json",
                headers: {
                    "content-type": "application/json;charset=utf-8"
                },
                data: dataObj
            });
        }

        function postTodo(url, todoObj) {
            return $http({
                method: 'POST',
                url: url,
                dataType: "json",
                headers: {
                    "content-type": "application/json;charset=utf-8"
                },
                data: todoObj
            });
        }

        function patchData(url, moodList) {
            return $http({
                method: 'PATCH',
                url: url,
                dataType: "json",
                headers: {
                    "content-type": "application/json;charset=utf-8"
                },
                data: moodList
            });
        }

        function patchNumber(url, number, provider, frequency) {
            return $http({
                method: 'PATCH',
                url: url,
                headers: {
                    "content-type": "application/json;charset=utf-8"
                },
                data: {
                    phone: number,
                    phone_provider: provider,
                    sms_frequency: frequency
                }
            });
        }

        function patchEntry(url, inputText, inputTitle, inputTag) {
            return $http({
                method: 'PATCH',
                url: url,
                dataType: "json",
                headers: {
                    "content-type": "application/json;charset=utf-8"
                },
                data: {
                    text: inputText,
                    title: inputTitle,
                    tags: inputTag

                }
            });
        }

        function flipPage(url) {
            return $http({
                method: 'GET',
                url: url
            });

        }

        function postJournal(url, journalObj) {
            return $http({
                method: 'POST',
                url: url,
                dataType: "json",
                headers: {
                    "content-type": "application/json;charset=utf-8"
                },
                data: journalObj
            });
        }

        function deleteData(url) {
            return $http({
                method: 'DELETE',
                url: url,
                headers: {
                    "content-type": "application/json;charset=utf-8"
                },
            });
        }

        return {
            get: getData,
            flipPage: flipPage,
            post: postData,
            postTodo: postTodo,
            postJournal: postJournal,
            patchEntry: patchEntry,
            patchNumber: patchNumber,
            delete: deleteData,
            patch: patchData
        };
    }


})(angular, window.currentUser);
