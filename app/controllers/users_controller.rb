class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:pseudo)
    message, user = UserCreatorService.new(user_params[:pseudo]).call

    if user
      flash[:notice] = message
      redirect_to new_user_path, notice: flash[:notice]
    else
      flash[:alert] = message
      redirect_to new_user_path
    end
  end
end
