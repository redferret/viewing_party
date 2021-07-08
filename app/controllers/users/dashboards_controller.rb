class Users::DashboardsController < ApplicationController
  before_action :find_friend, only: %i[show]
  before_action :set_user, only: %i[show]

  def show
    @friends = current_user.friends.uniq
    flash[:alert] = 'Sorry! Friend was not found.' if params[:email].present? && !@found_friend
    set_friendships if params[:add_friend].present?
    @hosted_parties = current_user.movie_parties
    @user_invitations = Invitation.find_invitations(current_user.id)
  end

  private

  def find_friend
    @found_friend = User.find_by(email: params[:email]) if params[:email].present?
    @found_friend = User.find_by(email: params[:add_friend]) if params[:add_friend].present?
  end

  def set_user
    @user = current_user
  end

  def set_friendships
    @friendships = current_user.add_friend(@found_friend)
    flash[:success] = 'Friend Added!'
  end
end
