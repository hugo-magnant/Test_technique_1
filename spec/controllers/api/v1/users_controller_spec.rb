require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "POST #create" do
    context "with valid params" do
      let(:valid_pseudo) { build(:user).pseudo }

      it "creates a new user" do
        post :create, params: { user: { pseudo: valid_pseudo } }, as: :json
        expect(JSON.parse(response.body)["pseudo"]).to eq(valid_pseudo)
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      let(:invalid_pseudo) { "XY" }

      it "does not create a new user" do
        post :create, params: { user: { pseudo: invalid_pseudo } }, as: :json
        expect(JSON.parse(response.body)["error"]).to eq("Invalid pseudo")
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
