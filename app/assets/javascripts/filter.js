$(document).ready(function(){
  $('#location-single-select').on('change', function() {
    filterRows(getFilterOptions());
  });

  $('#minimum_distance').on("keypress",function(e) {
    if (e.keyCode === 13) {
      filterRows(getFilterOptions());
    }
  });

  $('#minimum_distance').on("change",function(e) {
    filterRows(getFilterOptions());
  });

  $('#maximum_distance').on("keypress",function(e) {
    if (e.keyCode === 13) {
      filterRows(getFilterOptions());
    }
  });

  $('#maximum_distance').on("change",function(e) {
    filterRows(getFilterOptions());
  });

  $('#minimum_elevation').on("keypress",function(e) {
    if (e.keyCode === 13) {
      filterRows(getFilterOptions());
    }
  });

  $('#minimum_elevation').on("change",function(e) {
    filterRows(getFilterOptions());
  });

  $('#maximum_elevation').on("keypress",function(e) {
    if (e.keyCode === 13) {
      filterRows(getFilterOptions());
    }
  });

  $('#maximum_elevation').on("change",function(e) {
    filterRows(getFilterOptions());
  });

  function filterRows(options) {
    var tableContents = getTableContents();
    var selectedObjects = [];

    if (options.location !== "") {
      var objects = selectedObjects.length === 0 ? tableContents : selectedObjects;
      selectedObjects = filter(objects, options.location, 'location');
    }

    if (isNaN(options.minDistance) === false) {
      var objects = selectedObjects.length === 0 ? tableContents : selectedObjects;
      selectedObjects = filter(objects, options.minDistance, 'minDistance');
    }

    if (isNaN(options.maxDistance) === false) {
      var objects = selectedObjects.length === 0 ? tableContents : selectedObjects;
      selectedObjects = filter(objects, options.maxDistance, 'maxDistance');
    }

    var rejectedObjects = $.grep(tableContents, function(element){
      return $.inArray(element, selectedObjects) == -1;
    });

    for (var i = 0; i < selectedObjects.length; i++) {
      $("#" + selectedObjects[i].id).show();
    }

    for (var j = 0; j < rejectedObjects.length; j++) {
      $("#" + rejectedObjects[j].id).hide();
    }
  }

  function filter(objects, selection, filterBy) {
    acceptedObjects = [];

    $.each(objects, function(index, object) {
      if (filterBy === 'location') {
        if (object.location === selection) {
          acceptedObjects.push(object);
        }
      } else if (filterBy === 'minDistance') {
        if (object.distance >= selection) {
          acceptedObjects.push(object);
        }
      } else if (filterBy === 'maxDistance') {
        if (object.distance <= selection) {
          acceptedObjects.push(object);
        }
      }
    });

    return acceptedObjects;
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
});
