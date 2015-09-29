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

  it "login" do
    visit root_path
    click_on "Login"
    fill_in "Email Address", with: "sally@drew.com"
    fill_in "Password", with: "password"
    click_on "Login To Goober"
    expect(page).to have_content("Rider Dashboard")
    click_on "Logout"
    expect(page).to_not have_content("Rider Dashboard")
  end

  it "login as driver" do
    visit root_path
    click_on "Login"
    fill_in "Email Address", with: "drew@drew.com"
    fill_in "Password", with: "password"
    click_on "Login To Goober"
    expect(page).to have_content("Driver Dashboard")
    click_on "Logout"
    expect(page).to_not have_content("Driver Dashboard")
  end


end
