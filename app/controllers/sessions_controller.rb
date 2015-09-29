class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      if user.role == "rider"
        redirect_to rider_path(user)
      else
        redirect_to driver_path(user)
      end
    else
      flash.notice = "Invalid Login"
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end
end

