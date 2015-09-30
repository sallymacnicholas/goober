class Ride < ActiveRecord::Base
  validates :pickup, presence: true
  validates :dropoff, presence: true
  validates :passengers, presence: true
end

