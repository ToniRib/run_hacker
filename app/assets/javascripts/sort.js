function propertyCompareAscending(key) {
  return function(a, b) {
    if (a[key] > b[key]) {
      return -1;
    } else if (a[key] < b[key]) {
      return 1;
    } else {
      return 0;
    }
  };
}

function propertyCompareDescending(key) {
  return function(a, b) {
    if (a[key] < b[key]) {
      return -1;
    } else if (a[key] > b[key]) {
      return 1;
    } else {
      return 0;
    }
  };
}

function getTableContents() {
  var tableContents = $('#workouts-table tr:has(td)').map(function(index, value) {
    var $td =  $('td', this);
      return {
               date: $td.eq(0).text(),
               distance: parseFloat($td.eq(1).text()),
               speed: parseFloat($td.eq(2).text()),
               time: parseFloat($td.eq(3).text()),
               calories: parseFloat($td.eq(4).text()),
               location: $td.eq(5).text(),
               elevation: parseFloat($td.eq(6).text()),
               dataLink: this.dataset.link,
               id: this.id
             };
  });
  return tableContents;
}

$(document).ready(function() {
  $("table").on('click', 'tr[data-link]', function() {
    window.location = this.dataset.link;
  });

  $("[id$=-sort]").on('click', function() {
    var key = this.id.split('-')[0];
    var tableContents = getTableContents();

    if (tableContents[tableContents.length - 1][key] < tableContents[0][key]) {
      tableContents.sort(propertyCompareDescending(key));
    } else {
      tableContents.sort(propertyCompareAscending(key));
    }

    $("#workouts-table tbody").empty();

    for (var i = 0; i < tableContents.length; i++) {
      $("#workouts-table").append("<tr class='clickable-row' id='" +
                                  tableContents[i].id + "' data-link='" + 
                                  tableContents[i].dataLink + "'><td>" +
                                  tableContents[i].date + "</td><td>" +
                                  tableContents[i].distance + "</td><td>" +
                                  tableContents[i].speed + "</td><td>" +
                                  tableContents[i].time + "</td><td>" +
                                  tableContents[i].calories + "</td><td>" +
                                  tableContents[i].location + "</td><td>" +
                                  tableContents[i].elevation + "</td></tr>");
    }
  });
});