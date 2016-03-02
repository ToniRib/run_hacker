Rails.application.routes.draw do
  root "welcome#show"
  get "/auth/:provider/callback", to: "sessions#create"
  get "/dashboard",               to: "dashboard#show"
  get "/logout",                  to: "sessions#destroy"
end
