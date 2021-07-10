class Users::FriendshipsController < ApplicationController
  def create
    @found_friend = User.find_by(email: params[:email])

    if @found_friend.id == current_user.id
      flash[:alert] = "Can't add yourself as a friend"
    elsif !current_user.friends.include?(@found_friend)
      current_user.add_friend(@found_friend)
      flash[:success] = 'Friend Added!'
    else
      flash[:notice] = 'Friend Already Added'
    end

    redirect_to dashboard_path
  end

  def destroy
    @found_friend = User.find_by(email: params[:email])
    if current_user.friends.include?(@found_friend)
      current_user.remove_friend(@found_friend)
      flash[:success] = 'Friend Removed'
    end

    redirect_to dashboard_path
  end
end
