$(document).ready(function(){
  $('#location-single-select').on('change', function() {
    options = getFilterOptions();
    filterRows(options);
  });

  $('#minimum_distance').on("keypress",function(e) {
    if (e.keyCode === 13) {
      options = getFilterOptions();
      filterRows(options);
    }
  });

  $('#minimum_distance').on("change",function(e) {
    options = getFilterOptions();
    filterRows(options);
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

function filterRows(options) {
  var $allRows = $('.clickable-row');
  var selectedRows = [];

  if (options.location !== "") {
    var rows = selectedRows.length === 0 ? $allRows : selectedRows;
    selectedRows = filter(rows, options.location, 'location');
  }

  var rejectedRows = $.grep($allRows, function(element){
    return $.inArray(element, selectedRows) == -1
  });

  for (var i = 0; i < selectedRows.length; i++) {
    $(selectedRows[i]).show();
  }

  for (var j = 0; j < rejectedRows.length; j++) {
    $(rejectedRows[j]).hide();
  }
}

function filter(rows, selection, filterBy) {
  selectedRows = [];

  rows.each(function(index, row) {
    if (filterBy === 'location') {
      if ($(row).find('.workout-location').text() === selection) {
        selectedRows.push(row);
      }
    }
  });

  console.log(selectedRows);

  return selectedRows;
}

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
