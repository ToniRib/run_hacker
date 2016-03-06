class User < ActiveRecord::Base
  has_many :workouts, dependent: :destroy
  has_many :routes, through: :workouts

  validates :uid,   uniqueness: { scope: :provider }
  validates :token, presence: true

  def self.find_or_create_by_auth(auth)
    user = User.find_or_create_by(provider: auth[:provider],
                                  uid:      auth[:info][:id])

    user.token        = auth[:credentials][:token]
    user.display_name = auth[:info][:display_name]
    user.email        = auth[:info][:email]
    user.username     = auth[:info][:username]
    user.date_joined  = auth[:info][:date_joined]

    user.save

    user
  end

  def check_for_profile_photo
    unless image
      update_attribute(:image,
                       MmfProfilePhotoService.get_profile_photo(uid, token))
    end
  end

  def number_of_workouts
    workouts.count
  end

  def number_of_routes
    routes.count
  end

  def no_workouts_loaded
    number_of_workouts == 0
  end

  def no_routes_loaded
    number_of_routes == 0
  end

  def date_joined_formatted
    date_joined.strftime("%b %-d, %Y")
  end
end
