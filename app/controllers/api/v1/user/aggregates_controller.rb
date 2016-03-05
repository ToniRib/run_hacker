class Api::V1::User::AggregatesController < ApplicationController
  def index
    render json: current_user.workouts,
           serializer: ::UserAggregatesSerializer
  end
end
