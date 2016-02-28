class MmfProfilePhotoService
  def self.get_profile_photo(uid, token)
    set_up_connection(uid)

    response = @connection.get do |request|
      request.headers["Authorization"] = "Bearer #{token}"
      request.headers["Api-Key"] = ENV['MMF_API_KEY']
    end

    extract_photo_url(JSON.parse(response.body, symbolize_names: true))
  end

  private

  def self.extract_photo_url(response)
    response[:_links][:large][0][:href]
  end

  def self.set_up_connection(uid)
    @connection = Faraday.new(:url => "https://oauth2-api.mapmyapi.com/v7.1/user_profile_photo/#{uid}/") do |faraday|
      faraday.adapter  Faraday.default_adapter
    end
  end
end
