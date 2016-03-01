class WorkoutAggregateDataWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(id)
    MmfWorkoutAggregateService.load_workouts(id)
    MmfRouteService.load_routes(id)
  end
end
