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
        username: "LeelaElTigre",
        date_joined: "2011-09-20T19:16:52+00:00"
      }
    })
  end
end
