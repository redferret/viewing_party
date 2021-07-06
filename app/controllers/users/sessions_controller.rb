class Users::SessionsController < ApplicationController
  skip_before_action :authorized?, only: %i[create]

  def create
    @user = User.find_by(email: user_params[:email])

    if @user && @user.authenticate(user_params[:password])
      flash[:success] = 'Welcome back!'
      authorize @user
      redirect_to dashboard_path
    else
      flash[:alert] = 'Could not log you in!'
      redirect_to '/'
    end
  end

  def destroy
    @user = current_user
    log_out
    redirect_to '/'
  end

  private

  def user_params
    params[:user]
  end
end
