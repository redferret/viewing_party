class Users::MoviesController < ApplicationController
  def index
    @movies = []
    if params[:search_by_rating].present?
      @movies = MoviesAPI::Client.top_rated_movies
    elsif params[:search_trending].present?
      @movies = MoviesAPI::Client.trending_movies
    elsif params[:movie_title].present?
      @movies = MoviesAPI::Client.search_by_title(params[:movie_title])
    end
  end

  def show; end
end
