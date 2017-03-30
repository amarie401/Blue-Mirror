(function(ng) {
    ng.module('BlueMirrorApp').controller('MapController', function($state, $scope, $q, DataRequestService, UserService, uiGmapGoogleMapApi, uiGmapIsReady, $geolocation, $sce) {

        $scope.$watch('placeSearch()', function() {});

        $geolocation.getCurrentPosition({
            timeout: 60000
        }).then(function(position) {
            $scope.map = {
                center: {
                    latitude: position.coords.latitude,
                    longitude: position.coords.longitude
                },
                zoom: 11,
                control: {},
                markers: [],
                templateUrl: 'place.html',
                templateParameter: {
                    name: '',
                    address: '',
                    phone: '',
                    website: '',
                    rating: ''
                },
                place: '',
                result: ''
            };

        });

        uiGmapIsReady.promise().then(function(maps) {

            $scope.placeSearch = function() {
                var request = {
                    location: {
                        lat: $scope.map.center.latitude,
                        lng: $scope.map.center.longitude
                    },
                    radius: '3000',
                    query: 'mental health'
                };
                var map = $scope.map.control.getGMap();
                var service = new google.maps.places.PlacesService(map);

                if ($scope.map.markers.length === 0) {
                    service.textSearch(request, callback);
                }

                return;
            };

            $scope.mapResults = [];
            var callback = function(results, status) {
                if (status == google.maps.places.PlacesServiceStatus.OK) {
                    for (var i = 0; i < results.length; i++) {
                        createMarker(results[i], i);
                    }
                }
            };


            $scope.newArr = [];

            $scope.checkRating = function(rating) {
                if (rating) {
                    return 'Rating: ' + rating;
                } else {
                    return null;
                }
            };


            var createMarker = function(place, id) {
                var request = {
                    reference: place.reference
                };
                var detail = new google.maps.places.PlacesService($scope.map.control.getGMap());
                detail.getDetails(request, function(result, status) {
                    if (status == google.maps.places.PlacesServiceStatus.OK) {
                        $scope.newArr.push(result);

                        $scope.map.markers.push({
                            id: id,
                            latitude: place.geometry.location.lat(),
                            longitude: place.geometry.location.lng(),
                            name: result.name,
                            address: result.formatted_address,
                            phone: result.formatted_phone_number,
                            website: result.website,
                            rating: $scope.checkRating(result.rating),
                        });
                        var help = true;
                        $scope.$apply();
                    }
                });
            };

            $scope.onMarkerClicked = function(marker) {
                $scope.map.templateParameter = {
                    name: marker.name,
                    address: marker.address,
                    phone: marker.phone,
                    website: marker.website,
                    rating: marker.rating
                };
                $scope.$apply();

            };

            $scope.removeMarkers = function() {
                $scope.map.markers.length = 0;
            };

            $(window).resize(function() {

                if ($(window).width() <= 600) {

                    $scope.map.zoom = 10;
                } else {
                    $scope.map.zoom = 11;
                }

            });

        });
    });

})(angular);
