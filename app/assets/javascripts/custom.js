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
    if(data[i].y == 0) {
      data.splice(i, data.length);
      break
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
  })

  if (filtered[0] == undefined) {
    return 0;
  } else {
    return calculateAverage(filtered);
  }
}
