class Users::MoviesController < ApplicationController
  def show
    if params[:search_by_rating].present?
      flash[:info] = 'Search by Rating'
    elsif params[:movie_title].present?
      flash[:info] = 'Search by title'
    else

    end
  end
end
