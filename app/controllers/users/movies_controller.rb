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

  def show
    @movie = MoviesAPI::Client.movie_details(params[:id])
    @movie_cast = MoviesAPI::Client.movie_credits(params[:id])
    @movie_reviews = MoviesAPI::Client.movie_reviews(params[:id])
    # binding.pry
  end
end
