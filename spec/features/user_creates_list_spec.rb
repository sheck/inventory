require 'rails_helper'

feature "User creates list" do
  scenario "successfully from lists page" do
    visit root_path(as: create(:user))
    click_on "Lists"

    fill_in "Name", with: "Working vehicles"
    click_on "Create List"

    expect(page).to have_content "Working vehicles"
    expect_page_to_be_list_show
  end
  scenario "unsuccessfully from lists page"
  scenario "successfully after clicking 'add to list' on item"
  scenario "unsuccessfully after clicking 'add to list' on item"
end

def expect_page_to_be_list_show
  # there has to be a better way to do this
  expect(page).to have_content "Edit list name"
  expect(page).to have_content "Delete list"
end
