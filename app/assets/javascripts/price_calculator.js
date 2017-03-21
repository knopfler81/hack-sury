$(function(){
  if ("#trip_transportation_costs" != undefined, "#trip_min_passengers_required" != undefined) {
    $("#trip_transportation_costs, #trip_min_passengers_required, #trip_rental_costs").change(function(){
      var transportation_costs = parseInt($("#trip_transportation_costs").val());
      var rental_costs = parseInt($("#trip_rental_costs").val()) || 0;
      var min_passengers_required = parseInt($("#trip_min_passengers_required").val());
      var estimated_price_per_person = Math.round((transportation_costs + rental_costs) / (min_passengers_required + 1));
      $("#max_price_per_person").text("The maximum price per person is now $" + estimated_price_per_person + ".");
    });
  }

  $('input[name="trip[has_car]"]').on('change', function() {
    if ($(this).val() == 'true') {
      $('.trip_rental_costs').hide()
    } else {
      $('.trip_rental_costs').show()
    }
  });
});
