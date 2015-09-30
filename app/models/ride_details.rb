class RideDetails
  attr_reader :directions
  def initialize(ride)
    @directions = GoogleDirections.new(ride.pickup, ride.dropoff)
  end

  def eta
    directions.drive_time_in_minutes
  end

  def distance
    directions.distance_in_miles
  end
end

