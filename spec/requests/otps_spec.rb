require 'rails_helper'

RSpec.describe "Otps", type: :request do
  describe "GET /verify" do
    it "returns http success" do
      get "/otps/verify"
      expect(response).to have_http_status(:success)
    end
  end

end
