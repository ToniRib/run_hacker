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

  $('#minimum_date').on("change",function(e) {
    filterRows(getFilterOptions());
  });

  $('#maximum_date').on("change",function(e) {
    filterRows(getFilterOptions());
  });

  $('#minimum_date').on("keypress",function(e) {
    if (e.keyCode === 13) {
      filterRows(getFilterOptions());
    }
  });

  $('#maximum_date').on("keypress",function(e) {
    if (e.keyCode === 13) {
      filterRows(getFilterOptions());
    }
  });
});

function filterRows(options) {
  var tableContents = getTableContents();
  var selectedObjects = [];
  var objects = [];
  var selectionFlag = false;

  if (options.location !== "") {
    objects = selectionFlag === false ? tableContents : selectedObjects;
    selectedObjects = filter(objects, options.location, 'location');
    selectionFlag = true;
  }

  if (isNaN(options.minDistance) === false) {
    objects = selectionFlag === false ? tableContents : selectedObjects;
    selectedObjects = filter(objects, options.minDistance, 'minDistance');
    selectionFlag = true;
  }

  if (isNaN(options.maxDistance) === false) {
    objects = selectionFlag === false ? tableContents : selectedObjects;
    selectedObjects = filter(objects, options.maxDistance, 'maxDistance');
    selectionFlag = true;
  }

  if (isNaN(options.minElevation) === false) {
    objects = selectionFlag === false ? tableContents : selectedObjects;
    selectedObjects = filter(objects, options.minElevation, 'minElevation');
    selectionFlag = true;
  }

  if (isNaN(options.maxElevation) === false) {
    objects = selectionFlag === false ? tableContents : selectedObjects;
    selectedObjects = filter(objects, options.maxElevation, 'maxElevation');
    selectionFlag = true;
  }

  if (options.minDate !== "") {
    objects = selectionFlag === false ? tableContents : selectedObjects;
    selectedObjects = filter(objects, options.minDate, 'minDate');
    selectionFlag = true;
  }

  if (options.maxDate !== "") {
    objects = selectionFlag === false ? tableContents : selectedObjects;
    selectedObjects = filter(objects, options.maxDate, 'maxDate');
    selectionFlag = true;
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
    } else if (filterBy === 'minElevation') {
      if (object.elevation >= selection) {
        acceptedObjects.push(object);
      }
    } else if (filterBy === 'maxElevation') {
      if (object.elevation <= selection) {
        acceptedObjects.push(object);
      }
    } else if (filterBy === 'minDate') {
      if (object.date >= selection) {
        acceptedObjects.push(object);
      }
    } else if (filterBy === 'maxDate') {
      if (object.date <= selection) {
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
