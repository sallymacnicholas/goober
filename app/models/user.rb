class User < ActiveRecord::Base
  has_secure_password
  validates :password, confirmation: true
  validates :name, presence: true
  validates :phone_number, presence: true, format: {with:/\d/, message:"can only contain numbers"}
  validates :email, uniqueness: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :car_make, presence: true, unless: ->(user){user.role == "rider"}
  validates :car_model, presence: true, unless: ->(user){user.role == "rider"}
  validates :car_capacity, numericality: true, presence: true, unless: ->(user){user.role == "rider"}

  def active_ride
    Ride.where.not(status: "completed").where(rider_id: id).first
  end

  def driver
    if active_ride
      User.where(id: active_ride.driver_id).first
    end
  end

  def driver_rides
    Ride.where.not(status: "completed").where(driver_id: id).where.not(status: "completed").first
  end

  def completed_rides
    if role == "rider"
      Ride.where(status: "completed")
    else
      Ride.where(status: "completed")
    end
  end
end
