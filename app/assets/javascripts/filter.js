$(document).ready(function(){
  $('#location-single-select').on('change', function() {
    options = getFilterOptions();
    console.log(options)
    // filterRows(options);
  });

  $('#minimum_distance').on("keypress",function(e) {
    if (e.keyCode === 13) {

    }
  });

  $('#minimum_distance').on("change",function(e) {

  });

  $('#maximum_distance').on("keypress",function(e) {

  });

  $('#maximum_distance').on("change",function(e) {

  });

  $('#minimum_elevation').on("keypress",function(e) {
    if (e.keyCode === 13) {

    }
  });

  $('#minimum_elevation').on("change",function(e) {

  });

  $('#maximum_elevation').on("keypress",function(e) {
    if (e.keyCode === 13) {

    }
  });

  $('#maximum_elevation').on("change",function(e) {

  });
});

function getFilterOptions() {
  return {
    location: $('#location-single-select :selected').text(),
    minDistance: parseFloat($('#minimum_distance').val()),
    maxDistance: parseFloat($('#maximum_distance').val()),
    minDate: $('#minimum_date').val(),
    maxDate: $('#maximum_date').val(),
    minElevation: parseFloat($('#minimum_elevation').val()),
    maxElevation: parseFloat($('#maximum_elevation').val())
  };
}

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

function filterByLocation() {
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
}

function filterByMinimumElevation() {
  var $rows = $('.clickable-row');
  var minimumElevation = parseFloat($('#minimum_elevation').val());

  $rows.each(function(index, row) {
    var $row = $(row);
    var $rowElevation = parseFloat($row.find(".workout-elevation").text());

    if ($rowElevation >= minimumElevation) {
      $row.show();
    } else {
      $row.hide();
    }
  });
}

function filterByMaximumElevation() {
  var $rows = $('.clickable-row');
  var maximumElevation = parseFloat($('#maximum_elevation').val());

  $rows.each(function(index, row) {
    var $row = $(row);
    var $rowElevation = parseFloat($row.find(".workout-elevation").text());

    if ($rowElevation <= maximumElevation) {
      $row.show();
    } else {
      $row.hide();
    }
  });
}

function filterByBothElevations() {
  var $rows = $('.clickable-row');
  var maximumElevation = parseFloat($('#maximum_elevation').val());
  var minimumElevation = parseFloat($('#minimum_elevation').val());

  $rows.each(function(index, row) {
    var $row = $(row);
    var $rowElevation = parseFloat($row.find(".workout-elevation").text());

    if ($rowElevation <= maximumElevation && $rowElevation >= minimumElevation) {
      $row.show();
    } else {
      $row.hide();
    }
  });
}
