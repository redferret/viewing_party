class Users::MoviePartiesController < ApplicationController
  def new
    @friends = current_user.friends
    movie_id = params[:movie_id]
    @movie = MoviesAPI::Client.movie_details(movie_id)
  end

  def create
    @movie_party = MovieParty.new(movie_party_params)
    @movie_party.time_date = build_date_time
    current_user.movie_parties << @movie_party

    create_invitation

    flash[:success] = 'Movie Party Created!'

    redirect_to dashboard_path
  end

  private

  def create_invitation
    params[:friends].each do |friend_email|
      friend = User.find_by(email: friend_email)
      if friend
        friendship = current_user.friendships.find_by(friend_id: friend.id)
        Invitation.create(movie_party_id: @movie_party.id, friendship_id: friendship.id)
      end
    end
  end

  def movie_party_params
    params.permit(:movie_title, :movie_poster_path)
  end

  def build_date_time
    year = params[:date_of_viewing]['written_on(1i)'].to_i
    month = params[:date_of_viewing]['written_on(2i)'].to_i
    day = params[:date_of_viewing]['written_on(3i)'].to_i
    viewing_time = params[:time_of_viewing].split(':')

    DateTime.new(year, month, day, viewing_time[0].to_i, viewing_time[1].to_i, 0)
  end
end
