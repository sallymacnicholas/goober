class RidersController < ApplicationController
  before_action :current_user?, only: [:show]
  before_action :authorize_rider, only: [:show]

  def new
    @rider = User.new
  end

  def show
    @active_ride = current_user.active_ride
    @driver = current_user.driver
    @completed = current_user.completed_rides
  end

  def create
    @rider = User.new(rider_params)
    @rider.role = "rider"
    if @rider.save
      session[:user_id] = @rider.id
      redirect_to rider_path(@rider)
    else
      flash.now[:errors] = @rider.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def rider_params
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :phone_number,
                                 :password_confirmation)
  end

  def current_user?
    if current_user == nil
      redirect_to root_path
    end
  end

  def authorize_rider
    unless current_user.id == params[:id].to_i
      redirect_to root_path
    end
  end
end

