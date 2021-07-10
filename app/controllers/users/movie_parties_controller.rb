class Users::MoviePartiesController < ApplicationController
  def new
    @friends = current_user.friends
    movie_id = params[:movie_id]
    @movie = MoviesAPI::Client.movie_details(movie_id)
  end

  def create
    movie_party = MovieParty.new(movie_party_params)
    current_user.movie_parties << movie_party

    params[:friends].each do |friend_email|
      friend = User.find_by(email: friend_email)
      if friend
        friendship = current_user.friendships.find_by(friend_id: friend.id)
        invitation = Invitation.create(movie_party_id: movie_party.id, friendship_id: friendship.id)
      end
    end

    if movie_party
      flash[:success] = 'Movie Party Created!'
      redirect_to dashboard_path
    end
  end

  private

  def movie_party_params
    params.permit(:movie_title, :movie_poster_path)
  end
end
