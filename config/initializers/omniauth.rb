Rails.application.config.middleware.use OmniAuth::Builder do
  provider :mapmyfitness, ENV['MMF_API_KEY'], ENV['MMF_API_SECRET']
end
