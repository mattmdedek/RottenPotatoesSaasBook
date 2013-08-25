class ApplicationController < ActionController::Base
  protect_from_forgery
#  helper_method :current_user
  before_filter :current_user

  protected # prevents method from being invoked by a route
  def current_user
# we exploit the fact that find_by_id(nil) returns nil
    @current_user ||= Moviegoer.find(session[:user_id]) if session[:user_id]
    #redirect_to login_path and return unless @current_user
  end
end
