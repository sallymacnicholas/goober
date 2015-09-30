class RidesController < ApplicationController
  def new
    @ride = Ride.new 
  end

  def create
    @ride = Ride.new(ride_params)
      @ride.rider_id = current_user.id
    if @ride.save
      redirect_to rider_path(current_user)
    else
      flash.notice = @ride.errors.full_messages.join(", ")
      render :new
    end
  end

  def set_ride_ids
      #session[:user_id] = @rider.id
    if current_user.role == "rider"
      @ride.rider_id = current_user.id
    else
      @ride.driver_id = current_user.id
    end
  end

  def redirect_users
    if current_user.role == "rider"
      redirect_to rider_path(current_user)
    else
      redirect_to driver(current_user)
    end
  end

  private

  def ride_params
    params.require(:ride).permit(:pickup, :dropoff, :passengers)
  end
end
