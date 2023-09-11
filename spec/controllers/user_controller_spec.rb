require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "POST #create" do

    # Contexte où le pseudo est valide.
    context "with valid pseudo" do

      # Test pour vérifier qu'un utilisateur n'est pas créé avec un pseudo en minuscules.
      it "does not create a user with lowercase pseudo" do
        expect {
          post :create, params: { user: { pseudo: "abc" } }, format: :json
        }.not_to change(User, :count)

        expect(response).to have_http_status(:bad_request)
      end

      # Test pour vérifier si la réponse JSON retournée contient le statut 'created' et le pseudo.
      it "returns JSON response with created status and pseudo" do
        post :create, params: { user: { pseudo: "DEF" } }, format: :json
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["pseudo"]).to eq("DEF")
        expect(response).to have_http_status(:created)
      end
    end

    # Contexte où le pseudo n'est pas valide.
    context "with invalid pseudo" do

      # Test pour vérifier qu'un nouvel utilisateur n'est pas créé.
      it "does not create a new user" do
        expect {
          post :create, params: { user: { pseudo: "AB1" } }, format: :json
        }.not_to change(User, :count)
      end

      # Test pour vérifier si la réponse retournée a le statut 'bad_request'.
      it "returns JSON response with bad_request status" do
        post :create, params: { user: { pseudo: "AB1" } }, format: :json
        expect(response).to have_http_status(:bad_request)
      end
    end

    # Contexte où le pseudo existe déjà.
    context "with existing pseudo" do

      # Création d'un utilisateur existant pour les besoins du test.
      let!(:existing_user) { create(:user, pseudo: "XYZ") }

      # Test pour vérifier si un nouvel utilisateur est créé avec un pseudo unique
      # même si le pseudo donné existe déjà.
      it "generates a unique pseudo and creates a new user" do
        post :create, params: { user: { pseudo: "XYZ" } }, format: :json
        expect(User.last.pseudo).not_to eq(existing_user.pseudo)
      end
    end
  end
end
