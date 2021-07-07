class Users::MoviesController < ApplicationController
  def show
    if params[:search_by_rating].present?
      @movies = MoviesAPI::Client.get_top_rated
    elsif params[:movie_title].present?
      @movies = MoviesAPI::Client.search_by_title(params[:movie_title])
    else
      flash[:notice] = 'Discover Movies to Watch!'
    end
  end
end
