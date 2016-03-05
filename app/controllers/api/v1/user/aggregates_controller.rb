class Api::V1::User::AggregatesController < ApplicationController
  def index
    render json: User.find(current_user.id),
           serializer: ::UserAggregatesSerializer
  end
end
