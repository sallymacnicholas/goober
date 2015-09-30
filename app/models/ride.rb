class Ride < ActiveRecord::Base
  validates :pickup, presence: true
  validates :dropoff, presence: true
  validates :passengers, presence: true

  def rider
     User.where(id: rider_id)
  end

  def driver
    User.where(id: driver_id)
  end
end

