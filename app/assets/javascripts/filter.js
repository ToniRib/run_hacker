$(document).ready(function(){
  $('#location-single-select').on('change', function() {
    filterByLocation();
  });

  $('#minimum_distance').on("keypress",function(e) {
    if (e.keyCode === 13) {
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
    if (e.keyCode === 13) {
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

  $('#minimum_elevation').on("keypress",function(e) {
    if (e.keyCode === 13) {
      if ($('#maximum_elevation').val() !== "") {
        filterByBothElevations();
      } else {
        filterByMinimumElevation();
      }
    }
  });

  $('#minimum_elevation').on("change",function(e) {
    if ($('#maximum_elevation').val() !== "") {
      filterByBothElevations();
    } else {
      filterByMinimumElevation();
    }
  });

  $('#maximum_elevation').on("keypress",function(e) {
    if (e.keyCode === 13) {
      if ($('#minimum_elevation').val() !== "") {
        filterByBothElevations();
      } else {
        filterByMaximumElevation();
      }
    }
  });

  $('#maximum_elevation').on("change",function(e) {
    if ($('#minimum_elevation').val() !== "") {
      filterByBothElevations();
    } else {
      filterByMaximumElevation();
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
