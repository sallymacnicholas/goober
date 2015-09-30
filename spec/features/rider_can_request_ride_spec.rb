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
  before(:each) do
    visit root_path
    click_on "Login"
    fill_in "Email Address", with: "sally@drew.com"
    fill_in "Password", with: "password"
    click_on "Login To Goober"
  end

  it "can request a ride" do
    click_on "Request a Ride"
    fill_in "Pickup", with: "Turing"
    fill_in "Dropoff", with: "home"
    fill_in "Passengers", with: 2
    click_on "Submit Ride Request"
    expect(page).to have_content("Current Ride")
    expect(page).to have_content("Status: active")
  end

  it "can see updated status" do
    click_on "Request a Ride"
    fill_in "Pickup", with: "Turing"
    fill_in "Dropoff", with: "home"
    fill_in "Passengers", with: 2
    click_on "Submit Ride Request"
    expect(page).to have_content("Current Ride")
    expect(page).to have_content("Status: active")
    expect(page).to_not have_content("Completed Rides")
    rider.active_ride.update(status: "accepted", driver_id: driver.id)
    visit rider_path(rider)
    expect(page).to have_content("Status: accepted")
    expect(page).to_not have_content("Completed Rides")
    rider.active_ride.update(status: "completed", accepted_time: Time.now,
      pickup_time: Time.now, dropoff_time: Time.now)
    visit rider_path(rider)
    save_and_open_page
    expect(page).to have_content("Completed Rides")
  end


end
