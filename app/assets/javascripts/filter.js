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

  $('#minimum_distance').on("keypress",function(e) {
    if(e.keyCode === 13) {
      if ($('#maximum_distance').val() !== "") {
        filterByBothDistances();
      } else {
        filterByMinimumDistance();
      }
    }
  });

  $('#minimum_distance').on("change",function(e) {
    if ($('#maximum_distance').val() !== "") {
      filterByBothDistances();
    } else {
      filterByMinimumDistance();
    }
  });

  $('#maximum_distance').on("keypress",function(e) {
    if(e.keyCode === 13) {
      if ($('#minimum_distance').val() !== "") {
        filterByBothDistances();
      } else {
        filterByMaximumDistance();
      }
    }
  });

  $('#maximum_distance').on("change",function(e) {
    if ($('#minimum_distance').val() !== "") {
      filterByBothDistances();
    } else {
      filterByMaximumDistance();
    }
  });
});

function filterByMinimumDistance() {
  var $rows = $('.clickable-row');
  var minimumDistance = parseFloat($('#minimum_distance').val());

  $rows.each(function(index, row) {
    var $row = $(row);
    var $rowDistance = parseFloat($row.find(".workout-distance").text());

    if ($rowDistance >= minimumDistance) {
      $row.show();
    } else {
      $row.hide();
    }
  });
}

function filterByMaximumDistance() {
  var $rows = $('.clickable-row');
  var maximumDistance = parseFloat($('#maximum_distance').val());

  $rows.each(function(index, row) {
    var $row = $(row);
    var $rowDistance = parseFloat($row.find(".workout-distance").text());

    if ($rowDistance <= maximumDistance) {
      $row.show();
    } else {
      $row.hide();
    }
  });
}

function filterByBothDistances() {
  var $rows = $('.clickable-row');
  var maximumDistance = parseFloat($('#maximum_distance').val());
  var minimumDistance = parseFloat($('#minimum_distance').val());

  $rows.each(function(index, row) {
    var $row = $(row);
    var $rowDistance = parseFloat($row.find(".workout-distance").text());

    if ($rowDistance <= maximumDistance && $rowDistance >= minimumDistance) {
      $row.show();
    } else {
      $row.hide();
    }
  });
}
