class SessionsController < ApplicationController
  # user shouldn't have to be logged in before logging in!
  def create
    auth=request.env["omniauth.auth"]
    user=Moviegoer.find_by_provider_and_uid(auth["provider"],auth["uid"]) || Moviegoer.create_with_omniauth(auth)
    session[:user_id] = user.id
    flash[:notice] = "Signed in."
    redirect_to movies_path
  end
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'Logged out successfully.'
    redirect_to movies_path
  end
end
