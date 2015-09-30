class RidesController < ApplicationController
  def new
    @ride = Ride.new 
  end

  def create
    @ride = Ride.new(ride_params)
      @ride.rider_id = current_user.id
      @ride.eta = RideDetails.new(@ride).eta
      @ride.distance = RideDetails.new(@ride).distance
    if @ride.save
      redirect_to rider_path(current_user)
    else
      flash.now[:errors] = @ride.errors.full_messages.join(", ")
      render :new
    end
  end

  def update
    @ride = Ride.find(params[:id])
    if @ride.status == "active"
      @ride.update(driver_id: current_user.id,
                   accepted_time: Time.now,
                   status: "accepted")
    elsif @ride.status == "accepted"
      @ride.update(pickup_time: Time.now,
                   status: "picked up")
    else
      @ride.update(dropoff_time: Time.now,
                   status: "completed")
    end
    redirect_to driver_path(current_user)
  end

  private

  def ride_params
    params.require(:ride).permit(:pickup, :dropoff, :passengers)
  end
end
