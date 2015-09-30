class DriversController < ApplicationController
  before_action :current_user?, only: [:show]
  before_action :authorize_driver, only: [:show]
  def new
    @driver = User.new
  end

  def show
    @driver_ride = current_user.driver_rides
    @completed = current_user.completed_rides
  end

  def create
    @driver = User.new(driver_params)
    @driver.role = "driver"
    if @driver.save
      session[:user_id] = @driver.id
      redirect_to driver_path(@driver)
    else
      flash.notice = @driver.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def driver_params
    params.require(:user).permit(:name, :email, :password, :phone_number,
      :car_make, :car_model, :car_capacity, :password_confirmation)
  end

  def current_user?
    if current_user == nil || current_user.role == "rider"
      redirect_to root_path
    end
  end

  def authorize_driver
    unless current_user.id == params[:id].to_i
      redirect_to root_path
    end
  end
end
