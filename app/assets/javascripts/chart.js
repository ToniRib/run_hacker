function compare(a, b) {
  if (a.y > b.y) {
    return -1;
  } else if (a.y < b.y) {
    return 1;
  } else {
    return 0;
  }
}

function calculateAverage(array) {
  var total = 0;
  for (var i = 0; i < array.length; i++) {
    total += array[i];
  }
  var avg = total / array.length;

  return parseFloat(avg.toFixed(2));
}

function removeZeroes(data) {
  for(var i = 0; i < data.length; i++) {
    if (data[i].y === 0) {
      data.splice(i, data.length);
      break;
    }
  }

  return data;
}

function averageTotalTimeOrSpeed(dataset, minDistance, maxDistance) {
  var filtered = [];

  dataset.forEach(function(set){
    if (set[0] >= minDistance && set[0] <= maxDistance) {
      filtered.push(set[1]);
    }
  });

  if (filtered[0] === undefined) {
    return 0;
  } else {
    return calculateAverage(filtered);
  }
}

function updateChartDataWithAnimation(chart, data) {
  chart.series[0].setData(data);
  chart.series[0].update({
    animation: {
      duration: 250
    }
  });
}

function createFilteredSetForScatter(workouts, minDistance, maxDistance) {
  filtered = [];

  workouts.forEach(function(set){
    if (set[0] >= minDistance && set[0] <= maxDistance) {
      var x = set[1];
      var y = set[2];
      filtered.push([x, y]);
    }
  });

  return filtered;
}

function setYAxisTitle(chart, selection) {
  var units = getYAxisUnits(selection);

  chart.yAxis[0].setTitle({ text: selection + units });
}

function getPlotDataByLocation(workoutsByLocation, locations, minDistance, maxDistance) {
  var plotData = [];

  for (var location in workoutsByLocation) {
    if ($.inArray(location, locations) > -1) {
      plotData.push({
        name: location,
        y: averageTotalTimeOrSpeed(workoutsByLocation[location], minDistance, maxDistance)
      });
    }
  }

  plotData.sort(compare);

  return removeZeroes(plotData);
}

function getPlotDataBySeason(workoutsBySeason, minDistance, maxDistance) {
  var plotData = [];

  for (var season in workoutsBySeason) {
    plotData.push({
      name: season,
      y: averageTotalTimeOrSpeed(workoutsBySeason[season], minDistance, maxDistance)
    });
  }

  plotData.sort(compare);

  return removeZeroes(plotData);
}

function getYAxisUnits(selection) {
  var yAxisUnits = {
    "Total Time": " (min)",
    "Average Speed": " (mph)",
    "Time Spent Resting": " (min)",
    "Average Total Time": " (min)"
  };

  return yAxisUnits[selection];
}

function getMinDistance() {
  return parseFloat($('#minimum_distance').val());
}

function getMaxDistance() {
  return parseFloat($('#maximum_distance').val());
}

function createRange(minDistance, maxDistance) {
  return minDistance + ' - ' + maxDistance + ' mile ';
}

function getYAxisSelection() {
  return $('#y-axis').val();
}

function setChartTitle(chart, prefix, yAxisSelection, range) {
  chart.setTitle({ text: prefix + ' vs. ' + yAxisSelection + ' for ' + range + 'runs' });
}
