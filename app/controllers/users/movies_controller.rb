class Users::MoviesController < ApplicationController
  def index
    @movies = []
    if params[:search_by_rating].present?
      @movies = Movies::IndexFacade.top_rated_movies
    elsif params[:search_trending].present?
      @movies = Movies::IndexFacade.trending_movies
    elsif params[:search_upcoming].present?
      @movies = Movies::IndexFacade.upcoming_movies
    elsif params[:movie_title].present?
      @movies = Movies::IndexFacade.search_by_title(params[:movie_title])
    end
  end

  def show
    @movie = MoviesAPI::Client.movie_details(params[:id])
    @movie_cast = MoviesAPI::Client.movie_credits(params[:id])
    @first_10_castmembers = @movie_cast[:cast].first(10)
    @first_five_castmembers = @first_10_castmembers.first(5)
    @last_five_castmembers = @first_10_castmembers.last(5)
    @movie_reviews = MoviesAPI::Client.movie_reviews(params[:id])
  end
end
