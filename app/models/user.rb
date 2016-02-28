class User < ActiveRecord::Base
  has_many :workouts

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
      update_attribute(:image,
                       MmfProfilePhotoService.get_profile_photo(uid, token))
    end
  end

  def check_for_new_workouts
    MmfWorkoutAggregateService.new_workouts(uid, token, id)
  end

  def number_of_workouts
    workouts.count
  end

  def no_workouts_loaded
    number_of_workouts == 0
  end
end
