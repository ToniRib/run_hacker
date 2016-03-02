module OmniauthMacros
  def mock_auth_hash
    OmniAuth.config.mock_auth[:mapmyfitness] = OmniAuth::AuthHash.new({
      provider: "mapmyfitness",
      credentials: {
        token: ENV['TONI_MMF_TOKEN']
      },
      info: {
        id: ENV['TONI_MMF_UID'],
        display_name: "Toni Rib",
        email: "toni.marie.a@gmail.com",
        username: "LeelaElTigre"
      }
    })
  end
end
