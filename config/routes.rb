Rails.application.routes.draw do
  root "welcome#show"
  get "/auth/:provider/callback", to: "sessions#create"
  get "/logout",                  to: "sessions#destroy"

  get "/dashboard",               to: "user/dashboard#show"
  get "/temperature",             to: "user/temperature#index"
  get "/workouts",                to: "user/workouts#index"
  get "/workouts/:id",            to: "user/workouts#show",       as: "workout"

  namespace "api", defaults: { format: :json } do
    namespace "v1" do
      get "/user/aggregates", to: "user/aggregates#index"
    end
  end
end
