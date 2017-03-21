$(function() {
  if ($('#map').length > 0) {
    var directionDisplay;
    var directionsService = new google.maps.DirectionsService();
    var map;

    var start = new google.maps.LatLng();
    var myOptions = {
      zoom: 4
    }
    map = new google.maps.Map(document.getElementById("map"), myOptions);

    function renderDirections(result) {
      var directionsRenderer = new google.maps.DirectionsRenderer();
      directionsRenderer.setMap(map);
      directionsRenderer.setDirections(result);
    }

    function drawRoute(start, end) {
      directionsService.route({
        origin: start,
        destination: end,
        travelMode: google.maps.DirectionsTravelMode.DRIVING
      }, function(result) {
        renderDirections(result);
    //  directionsDisplay.setDirections(response);
    //  var leg = result.routes[ 0 ].legs[ 0 ];
    //  makeMarker( leg.start_location, icons.start, "title" );
    //  makeMarker( leg.end_location, icons.end, 'title' );

      });
    }

    $('#map').data('cities').forEach(function(city) {
      drawRoute(city.start, city.end);
    });
  }
});
