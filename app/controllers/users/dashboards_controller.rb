class Users::DashboardsController < ApplicationController
  before_action :set_friends

  def show
    find_a_friend if params[:find_friend_by_email].present?
    @hosted_parties = current_user.movie_parties
    @user_invitations = Invitation.find_invitations(current_user.id)
  end

  private

  def set_friends
    @friends = current_user.friends
  end

  def find_a_friend
    @found_friend = User.find_by(email: params[:find_friend_by_email])
    return if @found_friend

    flash[:notice] = 'Sorry! Friend was not found.'
    redirect_to dashboard_path
  end
end
