require 'rails_helper'

RSpec.describe RideDetails, type: :model do
  let! (:rider) { User.create name: "drew",
                              email: "sally@drew.com",
                              phone_number: "7209364687",
                              password: "password",
                              password_confirmation: "password",
                              role: "rider"}

  let! (:driver) { User.create name: "drew",
                               email: "drew@drew.com",
                               phone_number: "7209364687",
                               password: "password",
                               password_confirmation: "password",
                               role: "driver",
                               car_make: "Honda",
                               car_model: "Pilot",
                               car_capacity: 6}

  let! (:ride) { Ride.create pickup: "1530 spring water littleton co",
                             dropoff: "1510 blake street denver co",
                             passengers: 1 }

  it "can get ride distance/time details" do
    VCR.use_cassette('google-directions', :record => :once) do
      ride.eta = RideDetails.new(ride).eta
      ride.distance = RideDetails.new(ride).distance
    end
    expect(ride.distance).to eq(18)
    expect(ride.eta).to eq(35)
  end
end
