class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:pseudo)
    message, user = UserCreatorService.new(user_params[:pseudo]).call

    respond_to do |format|
      if user
        flash[:notice] = message
        format.html { redirect_to new_user_path, notice: flash[:notice] }
        format.json { render json: { pseudo: user.pseudo, message: message }, status: :created }
      else
        message = "Pseudo invalide : pseudo de 3 lettres majuscules uniquement !"
        format.html { redirect_to new_user_path, alert: message }
        format.json { render json: { error: "Invalid pseudo", message: message }, status: :bad_request }
      end
    end
  end
end
