require 'rails_helper'

feature "User creates item" do
  scenario "successfully" do
    user = User.create(email: "user@example.com", password: "password")
    visit root_path
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_button "Sign in"

    fill_in "Item name", with: "Stair car"
    fill_in "Item description", with: "It's a car with stairs"
    click_on "Add item"

    # expect(flash[:notice]).to match(/^Item was successfully added/)
    expect(page).to have_content "Stair car"
    expect(page).to have_content "It's a car with stairs"
  end
  scenario "that only they can see"
end
