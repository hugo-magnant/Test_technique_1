require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "assigns a new User to @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_pseudo) { build(:user).pseudo }

      it "creates a new user" do
        expect {
          post :create, params: { user: { pseudo: valid_pseudo } }
        }.to change(User, :count).by(1)
      end
    end

    context "with invalid params" do
      let(:invalid_pseudo) { "XY" }

      it "does not create a new user" do
        expect {
          post :create, params: { user: { pseudo: invalid_pseudo } }
        }.not_to change(User, :count)
      end
    end
  end
end
