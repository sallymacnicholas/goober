require 'rails_helper'

RSpec.describe User, type: :model do
  let! (:rider) { User.create name: "drew",
                           email: "sally@drew.com",
                           phone_number: "7209364687",
                           password: "password",
                           password_confirmation: "password",
                           role: "rider"
  }
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
                             passengers: 1
                               }

  it "has valid credentials" do
    expect(rider).to be_valid
    expect(driver).to be_valid
  end

  it "has unique email" do
    drew = User.create name: "sally", email: "sally@sally.com",
                       password: "password", password_confirmation: "password"

    expect(drew).not_to be_valid
  end

  it "driver is not valid without a car make" do
    driver.car_make = nil
    expect(driver).not_to be_valid
  end

  it "driver is not valid without a car_model" do
    driver.car_model = nil
    expect(driver).not_to be_valid
  end

  it "driver is not valid without car_capacity" do
    driver.car_capacity = nil
    expect(driver).not_to be_valid
  end

  it "must have valid phone number" do
    driver.phone_number = "asdf"
    expect(driver).not_to be_valid
  end

  it "car capacity must be a number" do
    driver.car_capacity = "asdf"
    expect(driver).not_to be_valid
  end

  it "rider has a ride" do
    ride.rider_id = rider.id
    expect(rider.active_ride.pickup).to eq("1530 spring water littleton co")
  end
end
