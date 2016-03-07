class Api::V1::User::AggregatesController < ApplicationController
  def index
    user = Presenters::DashboardPresenter.new(current_user)
    render json: user,
           serializer: ::UserAggregatesSerializer
  end
end
