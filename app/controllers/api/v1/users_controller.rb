module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        user_params = params.require(:user).permit(:pseudo)
        message, user = UserCreatorService.new(user_params[:pseudo]).call

        if user
          render json: { pseudo: user.pseudo, message: message }, status: :created
        else
          render json: { error: "Invalid pseudo", message: message }, status: :bad_request
        end
      end
    end
  end
end
