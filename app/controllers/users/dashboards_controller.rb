class Users::DashboardsController < ApplicationController
  def show
    @user = current_user
    @friends = @user.friends.uniq
    if params[:email].present?
      @found_friend = User.find_by(email: params[:email])
      flash[:alert] = 'Sorry! Friend was not found.' unless @found_friend
    end
    if params[:add_friend].present?
      friend = User.find_by(email: params[:add_friend])
      @friendships = @user.add_friend(friend)
      flash[:success] = 'Friend Added!'
    end
  end
end
