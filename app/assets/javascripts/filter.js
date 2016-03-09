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

  function filterRows(options) {
    var tableContents = getTableContents();
    // console.log(tableContents);
    // var $allRows = $('.clickable-row');
    var selectedObjects = [];

    if (options.location !== "") {
      var objects = selectedObjects.length === 0 ? tableContents : selectedObjects;
      selectedObjects = filter(objects, options.location, 'location');
    }

    // console.log(selectedObjects);

    if (isNaN(options.minDistance) === false) {
      var objects = selectedObjects.length === 0 ? tableContents : selectedObjects;
      // console.log(objects);
      selectedObjects = filter(objects, options.minDistance, 'minDistance');
    }

    // console.log(selectedObjects);

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
      }
    });

    // console.log(objects);

    // console.log(acceptedObjects);

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
