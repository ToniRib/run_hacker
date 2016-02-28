class User < ActiveRecord::Base
  validates :uid,   uniqueness: { scope: :provider }
  validates :token, presence: true

  def self.find_or_create_by_auth(auth)
    user = User.find_or_create_by(provider: auth[:provider],
                                  uid:      auth[:info][:id])
    user.token        = auth[:credentials][:token]
    user.display_name = auth[:info][:display_name]
    user.email        = auth[:info][:email]
    user.username     = auth[:info][:username]

    user.save

    user
  end

  def check_for_profile_photo
    unless image
      image_url = MmfProfilePhotoService.get_profile_photo(uid, token)
      update_attribute(:image, image_url)
    end
  end
end
