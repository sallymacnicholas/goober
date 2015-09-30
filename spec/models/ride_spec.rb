require 'rails_helper'

RSpec.describe Ride, type: :model do
  let! (:ride) { Ride.create pickup: "turing", dropoff: "home", passengers: 1 }

  it "is not valid without pickup location" do
    ride.pickup = nil
    expect(ride).to_not be_valid
  end

  it "is not valid without dropoff location" do
    ride.dropoff = nil
    expect(ride).to_not be_valid
  end

  it "is not valid without passengers" do
    ride.passengers = nil
    expect(ride).to_not be_valid
  end
end
