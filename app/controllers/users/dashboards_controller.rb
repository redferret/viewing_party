class Users::DashboardsController < ApplicationController
  before_action :set_user

  def show
    @friends = current_user.friends
    if params[:find_friend_by_email].present?
      @found_friend = User.find_by(email: params[:find_friend_by_email])
      if !@found_friend
        flash[:notice] = 'Sorry! Friend was not found.'
      end
    end
  end

  def create
    @found_friend = User.find_by(email: params[:email])
    if !current_user.friends.include?(@found_friend)
      current_user.add_friend(@found_friend)
      @friends = current_user.friends
      flash[:success] = 'Friend Added!'
    else
      flash[:notice] = 'Friend Already Added'
    end
    redirect_to dashboard_path
  end

  private

  def set_user
    @user = current_user
  end
end
