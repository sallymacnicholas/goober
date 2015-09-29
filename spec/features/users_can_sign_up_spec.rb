require 'rails_helper'

RSpec.describe User, type: :feature do
  it "can sign up as a rider" do
    visit root_path
    click_on "Rider"
    fill_in "Name", with: "sally"
    fill_in "Email Address", with: "sally@sally.com"
    fill_in "Phone Number", with: "1234567890"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    click_on "Create Account"
    expect(page).to have_content("Rider Dashboard")
  end

  xit "can sign up as a rider" do
    visit root_path
    click_on "Driver"
    fill_in "Name", with: "sally"
    fill_in "Email Address", with: "sally@sally.com"
    fill_in "Phone Number", with: "1234567890"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    fill_in "Car Make", with: "Honda"
    fill_in "Car Model", with: "pilot"
    fill_in "How many goobers can you fit in your car?", with: 2
    click_on "Create Account"
    expect(page).to have_content("Driver Dashboard")
  end
end
