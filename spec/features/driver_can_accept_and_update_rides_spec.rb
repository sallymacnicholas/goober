require 'rails_helper'

RSpec.describe User, type: :feature do
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
                             passengers: 1 }

  let! (:ride2) { Ride.create pickup: "2997 wewatta way denver,co",
                             dropoff: "1510 blake street denver co",
                             passengers: 10 }

  before(:each) do
    VCR.use_cassette('driver-ride', :record => :once) do
    visit root_path
    click_on "Login"
    fill_in "Email Address", with: "drew@drew.com"
    fill_in "Password", with: "password"
    click_on "Login To Goober"
    end
  end

  it "can accept a ride" do
    VCR.use_cassette('driver-ride-2', :record => :once) do
      expect(page).to have_content("Available Rides")
      expect(page).to_not have_content("Current Ride")
      click_on "Accept Ride"
      expect(page).to have_content("Pick up Rider")
      click_on "Pick up Rider"
      expect(page).to have_content("Complete Ride")
      click_on "Complete Ride"
      expect(page).to_not have_content("Current Ride")
    end
  end

  it "does not see rides with more than car capacity" do
    expect(page).to_not have_content("2997 wewatta way denver, co")
  end

end
