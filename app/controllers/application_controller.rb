class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorized?
  helper_method :current_user, :logged_in?

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def authorized?
    @user = current_user if logged_in?
    redirect_to root_path unless logged_in?
  end

  def authorize(user)
    session[:user_id] = user.id
  end

  def log_out
    session[:user_id] = nil
  end
end
