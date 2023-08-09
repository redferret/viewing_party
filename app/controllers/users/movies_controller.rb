class Users::MoviesController < ApplicationController
  def index
    @movies = []
    if params[:search_by_rating].present?
      @movies = MoviesService.top_rated_movies
    elsif params[:search_trending].present?
      @movies = MoviesService.trending_movies
    elsif params[:search_upcoming].present?
      @movies = MoviesService.upcoming_movies
    elsif params[:movie_title].present?
      @movies = MoviesService.search_by_title(params[:movie_title])
    end
  end

  def show
    @movie = MoviesService.movie_details(params[:id])
  end
end
