require "rails_helper"

RSpec.describe User, type: :model do
  it { should validate_presence_of(:token) }
  it { should validate_uniqueness_of(:uid).scoped_to(:provider) }

  describe ".find_or_create_by_auth" do
    it "creates a new user if user cannot be found" do
      expect(User.count).to eq(0)

      user = User.find_or_create_by_auth(auth_hash)

      expect(User.count).to eq(1)
      expect(user.provider).to eq(auth_hash[:provider])
      expect(user.uid).to eq(auth_hash[:info][:id])
      expect(user.token).to eq(auth_hash[:credentials][:token])
      expect(user.display_name).to eq(auth_hash[:info][:display_name])
      expect(user.email).to eq(auth_hash[:info][:email])
      expect(user.username).to eq(auth_hash[:info][:username])
    end

    it "finds the user if user already exists" do
      User.find_or_create_by_auth(auth_hash)

      expect(User.count).to eq(1)

      user = User.find_or_create_by_auth(auth_hash)

      expect(User.count).to eq(1)
      expect(user.provider).to eq(auth_hash[:provider])
      expect(user.uid).to eq(auth_hash[:info][:id])
      expect(user.token).to eq(auth_hash[:credentials][:token])
      expect(user.display_name).to eq(auth_hash[:info][:display_name])
      expect(user.email).to eq(auth_hash[:info][:email])
      expect(user.username).to eq(auth_hash[:info][:username])
    end
  end

  describe "check_for_profile_photo" do
    it "does not update image if image exists" do
      user = create(:user)

      expect(user.image).to eq(grace_hopper_image)

      user.check_for_profile_photo

      expect(user.image).to eq(grace_hopper_image)
    end

    it "gets image from MapMyFitness if user does not have one" do
      user = create(:user, token: ENV['TONI_MMF_TOKEN'],
                           uid:   ENV['TONI_MMF_UID'],
                           image: nil)

      VCR.use_cassette("toni_profile_photo") do
        user.check_for_profile_photo
      end

      expect(user.image).to eq(toni_profile_photo)
    end
  end

  describe "#number_of_workouts" do
    it "returns the number of workouts a user has" do
      user = create(:user_with_workouts_and_routes)

      expect(user.number_of_workouts).to eq(2)
    end
  end

  describe "#number_of_routes" do
    it "returns the number of routes a user has" do
      user = create(:user_with_workouts_and_routes)

      expect(user.number_of_routes).to eq(2)
    end
  end

  describe "#no_workouts_loaded" do
    it "returns true if the user has no workouts" do
      user = create(:user)

      expect(user.no_workouts_loaded).to be true
    end

    it "returns false if the user has at least one workout" do
      user = create(:user_with_workouts_and_routes)

      expect(user.no_workouts_loaded).to be false
    end
  end

  describe "#no_routes_loaded" do
    it "returns true if the user has no routes" do
      user = create(:user)

      expect(user.no_routes_loaded).to be true
    end

    it "returns false if the user has at least one route" do
      user = create(:user_with_workouts_and_routes)

      expect(user.no_routes_loaded).to be false
    end
  end

  describe "#locations_as_city_and_state" do
    it "returns an array of unique cities and states" do
      location1 = create(:location, city: "Denver", state: "CO")
      location2 = create(:location, city: "Los Angeles", state: "CA")
      route1 = create(:route, location: location1)
      route2 = create(:route, location: location2)
      workout1 = create(:workout, route: route1)
      workout2 = create(:workout, route: route2)
      user = create(:user)
      user.workouts << [workout1, workout2]

      location1, location2 = user.locations_as_city_and_state
      actual_locations = ["Denver, CO", "Los Angeles, CA"]

      expect(actual_locations.include?(location1)).to be true
      expect(actual_locations.include?(location2)).to be true
    end
  end

  def auth_hash
    {
      provider: "mapmyfitness",
      credentials: {
        token: "2da174759b2da09f1638381b90d4cd71e9d9638e"
      },
      info: {
        id: 9338201,
        display_name: "Display Name",
        email: "example@gmail.com",
        username: "username"
      }
    }
  end

  def grace_hopper_image
    "http://a3.files.biography.com/image/upload/c_fit,cs_srgb," \
    "dpr_1.0,h_1200,q_80,w_1200/MTE5NTU2MzE2NjYxNTE1Nzg3.jpg"
  end

  def toni_profile_photo
    "https://graph.facebook.com/1277220131/picture?height=300&width=300"
  end
end
