Rails.application.routes.draw do
  root "welcome#show"
  get "/auth/:provider/callback", to: "sessions#create"
  get "/logout",                  to: "sessions#destroy"

  get "/dashboard",               to: "users/dashboard#show"
  get "/temperature",             to: "users/temperature#index"
end
