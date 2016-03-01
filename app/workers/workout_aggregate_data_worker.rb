class WorkoutAggregateDataWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(id)
    MmfWorkoutAggregateService.load_workouts(id)
    # MmfRouteService.update_workouts_with_route_info(id)
  end
end
