class DriversController < ApplicationController
  def new
    @driver = User.new
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
end
