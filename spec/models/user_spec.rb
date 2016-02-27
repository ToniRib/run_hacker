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
end
