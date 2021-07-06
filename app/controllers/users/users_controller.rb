class Users::UsersController < ApplicationController
  skip_before_action :authorized?, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      authorize @user
      flash[:success] = 'Welcome to our app!'
      redirect_to dashboard_path
    else
      flash[:alert] = 'Could not register you'
      redirect_to new_register_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
