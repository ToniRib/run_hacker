function pollForAggregates() {
  $.ajax({
    type: "GET",
    url: "/api/v1/user/aggregates",
    success: function(data) {
      updateAggregates(data);
    }
  })
}

function updateAggregates(data) {
  $("#total-workouts").text(data.total_workouts);
  $("#total-calories").text(data.total_calories + " kcal");
  $("#total-distance").text(data.total_distance + " miles");
  $("#average-distance").text(data.average_run_distance + " miles");
  $("#total-time").text(data.total_time + " hours");
}
