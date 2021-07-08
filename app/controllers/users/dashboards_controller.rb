class Users::DashboardsController < ApplicationController
  before_action :set_friends

  def show
    find_a_friend if params[:find_friend_by_email].present?
  end

  def create
    @found_friend = User.find_by(email: params[:email])
    if !current_user.friends.include?(@found_friend)
      current_user.add_friend(@found_friend)
      flash[:success] = 'Friend Added!'
    else
      flash[:notice] = 'Friend Already Added'
    end
    redirect_to dashboard_path
  end

  private

  def set_friends
    @friends = current_user.friends
  end

  def find_a_friend
    @found_friend = User.find_by(email: params[:find_friend_by_email])
    flash[:notice] = 'Sorry! Friend was not found.' unless @found_friend
  end
end
