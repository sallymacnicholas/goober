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

  it "can sign up as a rider" do
    visit root_path
    click_on "Driver"
    fill_in "Name", with: "sally"
    fill_in "Email Address", with: "drew@drew.com"
    fill_in "Phone Number", with: "1234567890"
    fill_in "user[password]", with: "wtf"
    fill_in "user[password_confirmation]", with: "wtf"
    fill_in "Car Make", with: "Honda"
    fill_in "Car Model", with: "pilot"
    fill_in "How many goobers can you fit in your car?", with: 2
    click_on "Create Account"
    expect(page).to have_content("Driver Dashboard")
  end

  it "gets form again if fields aren't filled out" do
    visit root_path
    click_on "Rider"
    click_on "Create Account"
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content("Password confirmation doesn't match Password")
    expect(page).to have_content("Phone number can't be blank")
    expect(page).to have_content("Phone number can only contain numbers")
    expect(page).to have_content("Email is invalid")
  end

  it "driver gets form again if fields are filled out" do
    visit root_path
    click_on "Driver"
    click_on "Create Account"
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content("Password confirmation doesn't match Password")
    expect(page).to have_content("Phone number can't be blank")
    expect(page).to have_content("Phone number can only contain numbers")
    expect(page).to have_content("Email is invalid")
    expect(page).to have_content("Car make can't be blank")
    expect(page).to have_content("Car model can't be blank")
    expect(page).to have_content("Car capacity is not a number")
    expect(page).to have_content("Car capacity can't be blank")
  end
end
