class Users::DashboardsController < ApplicationController
  def show
    @user = current_user
  end
end
