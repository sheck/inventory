require 'rails_helper'

feature "User creates item" do
  scenario "successfully" do
    user = FactoryGirl.create(:user)
    visit root_path(as: user)

    fill_in "Item name", with: "Stair car"
    fill_in "Item description", with: "It's a car with stairs"
    click_on "Add item"

    # expect(flash[:notice]).to match(/^Item was successfully added/)
    expect(page).to have_content "Stair car"
    expect(page).to have_content "It's a car with stairs"
  end
  scenario "that only they can see" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user, email: "user2@example.com")

    user2.items.create(name: "Muscle shirt")
    visit root_path(as: user)

    expect(page).to_not have_content "Muscle shirt"
  end
end
