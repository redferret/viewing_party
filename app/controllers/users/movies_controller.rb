class Users::MoviesController < ApplicationController
  def show
    if params[:search_by_rating].present?
      flash[:notice] = 'Search by Rating'
    elsif params[:movie_title].present?
      flash[:notice] = 'Search by title'
    else
      flash[:notice] = 'Discover Movies to Watch!'
    end
  end
end
