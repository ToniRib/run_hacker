$(document).ready(function(){


  $('#location-single-select').on('change', function() {
    var $rows = $('.clickable-row');
    var selectedLocation = $('#location-single-select :selected').text();

    $rows.each(function(index, row) {
      var $row = $(row);
      var $rowLocation = $row.find(".workout-location").text();

      if ($rowLocation === selectedLocation || selectedLocation === "") {
        $row.show();
      } else {
        $row.hide();
      }
    });
  });
});
