class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    u = User.find_by(email: params[:user][:email].strip.downcase)
    if u != nil && u.authenticate(params[:user][:password])
      session["user_id"] = u.id.to_s
      redirect_to session["redirect_from"] || home_path
    else
      redirect_to new_session_path
    end
  end

  def destroy
    session.destroy
    if request.env["HTTP_REFERER"].include? "raychasers.com"
      session["user_id"] = nil
      redirect_to "/"
    else
      redirect_to new_session_path
    end
  end
end
