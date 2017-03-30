(function(ng) {
    ng.module('BlueMirrorApp').controller('MedicineController', function($state, $scope, $compile, $timeout, uiCalendarConfig, $q, DataRequestService, UserService) {

        /* MEDICATION FUNCTIONS */

        $scope.medications = [];

        $scope.medObj = {
            name: ''
        };

        // total meds
        $scope.totalmeds = function() {
            return $scope.medications.length;
        };

        // add meds
        $scope.addMeds = function() {
            $scope.medObj.name = $scope.input;
            $scope.error = '';
            $scope.input = '';
        };

        // get meds
        $q.when(DataRequestService.get('/meds')).then((response) => {

            $scope.defaultMeds = response.data;

            for (var med in $scope.defaultMeds) {
                $scope.allMedications = $scope.defaultMeds[med];
                $scope.medications.push($scope.allMedications);
            }


        }).catch((error) => {
            console.log(error);
        });

        // post meds
        $scope.postMeds = function() {
            // debugger;

            if ($scope.input === undefined || $scope.input === '') {

                $scope.error = "Please enter a medication";

            } else {
                $scope.addMeds();

                $q.when(DataRequestService.postTodo('/meds', $scope.medObj)).then((response) => {

                    $scope.currentMeds = response.data.location;
                    $scope.medications.push($scope.currentMeds);

                }).catch((error) => {
                    console.log(error);
                });

            }
        };

        // delete meds
        $scope.deleteMeds = function() {

            for (let i = $scope.medications.length - 1; i >= 0; i--) {

                if ($scope.medications[i].done === true) {
                    $q.when(DataRequestService.delete(`/meds/${$scope.medications[i].id}`)).then((response) => {


                    }).catch((error) => {
                        console.log(error);
                    });

                    $scope.medications.splice(i, 1);
                }
            }
        };

        $scope.tookMeds = function() {
            $scope.title = 'Took meds';
            $scope.from = moment().startOf('day').toDate();
            $scope.eventObj = {
                title: $scope.title,
                completed: true
            };

            $scope.addEvent();
        };

        $scope.$watch('calendarWatch', function() {
            $scope.hasTakenMeds();
        });


        $scope.hasTakenMeds = function(event) {
            if (typeof $('.calendar').fullCalendar('clientEvents') === 'undefined') return false;

            let todaysEvents = $('.calendar').fullCalendar('clientEvents').filter(event => {
                return moment(event.start).format('YYYY MM DD') === moment().format('YYYY MM DD');
            });

            let todaysTakenEvents = todaysEvents.filter(event => {
                return event.title === "Took meds" || event.title === "Took meds ✅";
            });

            return todaysTakenEvents.length > 0;
        };


        /* CALENDAR FUNCTIONS  */

        $scope.currentView = 'month';
        $scope.calendarWatch = 0;

        /* event source that contains custom events on the scope */
        $scope.events = [];

        $scope.from = '';
        $scope.eventObj = {
            title: '',
            completed: false,
            from: ''
        };

        /* add custom event*/
        $scope.addEvent = function() {

            $q.when(DataRequestService.post('/events', $scope.eventObj)).then((response) => {
                $scope.eventId = response.data.location.id;
                $scope.postTitle = response.data.location.title;

                if ($scope.postTitle == 'Took meds') {
                  $scope.postTitle += ' ✅'
                }
                $scope.events.push({
                    _id: $scope.eventId,
                    title: $scope.postTitle,
                    start: moment($scope.from),
                    allDay: true,
                    stick: true
                });

                $scope.eventObj = {
                    title: '',
                    completed: false,
                    from: ''
                };


            }).catch((error) => {
                console.log(error);
            });


            $scope.eventObj.title = $scope.title;
            $scope.eventObj.from = moment($scope.from);
            $scope.title = '';
        };

        /* Change View */
        $scope.changeView = function(view, calendar) {
            $scope.currentView = 'view';
            uiCalendarConfig.calendars[calendar].fullCalendar('changeView', view);
        };


        /* Change View */
        $(window).resize(function() {

            if ($(window).width() <= 600) {
                $('.calendar').fullCalendar('changeView', 'basicDay', 'calendar');
            } else {
                $('.calendar').fullCalendar('changeView', 'month', 'calendar');
            }

        });
        $scope.renderCalender = function(calendar) {
            $timeout(function() {
                if (uiCalendarConfig.calendars[calendar]) {
                    uiCalendarConfig.calendars[calendar].fullCalendar('render');
                }
            });
        };

        /* Event Render */
        $scope.eventRender = function(event, element, view) {
            $scope.calendarWatch++;

            element.attr({
                'tooltip': event.title,
                'tooltip-append-to-body': true
            });
            $compile(element)($scope);

            if (event.title == 'Took meds') {
                element.append(" ✅");
            }

            element.append("<span class='closeon'>❌</span>");
            element.append("<span class='star'>⭐</span>");
            element.find(".closeon").click(function() {
                $q.when(DataRequestService.delete(`/events/${event._id}`)).then((response) => {

                    $('.calendar').fullCalendar('removeEvents', event._id);
                }).catch((error) => {
                    console.log(error);
                });
            });
        };

        /* config object */
        $scope.uiConfig = {
            calendar: {
                editable: false,
                eventClick: function(event) {
                    $(".closon").click(function() {
                        $('.calendar').fullCalendar('removeEvents', event._id);
                    });
                },
                eventRender: $scope.eventRender
            }
        };


        /* event sources array*/
        $scope.eventSources = [$scope.events];
        $scope.eventSources2 = [$scope.calEventsExt, $scope.eventsF, $scope.events];


        /* get events */
        $q.when(DataRequestService.get('/events')).then((response) => {

            $scope.loadedEvents = response.data;

            $('.calendar').fullCalendar('addEventSource', $scope.loadedEvents);

        }).catch((error) => {
            console.log(error);
        });

    });
})(angular);
