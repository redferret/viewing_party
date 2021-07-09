class Users::MoviePartiesController < ApplicationController
  def new
    @friends = current_user.friends
  end

  def create

  end
end
