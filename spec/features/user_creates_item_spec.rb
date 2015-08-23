require 'rails_helper'

feature "User creates item" do

  scenario "with valid attributes" do
    visit_page_as_user

    fill_in "Name", with: "Stair car"
    fill_in "Description", with: "It's a car with stairs"
    click_on "Add item"

    expect(page).to have_content "successfully added"
    expect(page).to have_content "Stair car"
    expect(page).to have_content "It's a car with stairs"
  end

  scenario "with invalid attributes" do
    visit_page_as_user

    fill_in "Name", with: ""
    click_on "Add item"

    expect(page).to have_content "can't be blank"
  end

  scenario "that only they can see" do
    user = create(:user)
    user2 = create(:user, email: "user2@example.com")

    user2.items.create(name: "Muscle shirt")
    visit items_path(as: user)

    expect(page).to_not have_content "Muscle shirt"
  end
end

def visit_page_as_user
  visit root_path(as: create(:user))
end
