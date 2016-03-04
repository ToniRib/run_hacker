Rails.application.routes.draw do
  root "welcome#show"
  get "/auth/:provider/callback", to: "sessions#create"
  get "/logout",                  to: "sessions#destroy"

  get "/dashboard",               to: "user/dashboard#show"
  get "/temperature",             to: "user/temperature#index"
  get "/workouts",                to: "user/workouts#index"
  get "/workouts/:id",            to: "user/workouts#show"
end
