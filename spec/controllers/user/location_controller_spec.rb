require "rails_helper"

RSpec.describe User::LocationController, type: :controller do
  describe "GET #index" do
    it "responds with successful 200 HTTP status code" do
      user = create(:user)
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      get :index

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
end
