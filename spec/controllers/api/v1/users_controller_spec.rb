require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "POST #create" do
    context "with valid params" do
      it "creates a new user" do
        post :create, params: { user: { pseudo: "XYZ" } }, as: :json
        expect(JSON.parse(response.body)["pseudo"]).to eq("XYZ")
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      it "does not create a new user" do
        post :create, params: { user: { pseudo: "XY" } }, as: :json
        expect(JSON.parse(response.body)["error"]).to eq("Invalid pseudo")
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
