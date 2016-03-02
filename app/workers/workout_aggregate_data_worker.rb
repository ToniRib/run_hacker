class WorkoutAggregateDataWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(id)
    MmfWorkoutAggregateService.load_workouts(id)
    MmfRouteService.load_routes(id)
    GoogleGeocoderService.update_routes_with_zipcodes(id)
    GoogleElevationService.update_routes_with_elevation(id)
    # WeathersourceTemperatureService.update_workouts_with_temperature(id)
  end
end
