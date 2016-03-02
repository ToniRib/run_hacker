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

    it "gets image if user does not have one" do
      
    end
  end

  def auth_hash
    {
      provider:    "mapmyfitness",
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
end
