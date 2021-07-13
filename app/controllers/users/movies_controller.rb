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
    @movie = Movies::ShowFacade.movie_details(params[:id])
  end
end
