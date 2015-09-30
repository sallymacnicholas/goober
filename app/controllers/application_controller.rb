class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :active_rides

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def active_rides
    Ride.where(status: "active").where("passengers <= ?",
      current_user.car_capacity)
  end

end
