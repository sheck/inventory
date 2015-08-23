require 'rails_helper'

feature "User views list" do
  scenario "by clicking on list from index" do
    user = create(:user)
    list = create(:list, user: user, name: "Working vehicles")
    visit root_path(as: user)

    click_on "Lists"
    click_on "Working vehicles"

    expect(page).to have_content("Working vehicles")
    expect_page_to_be_list_show
  end
  scenario "by clicking on list from item show"
end

def expect_page_to_be_list_show
  # there has to be a better way to do this
  expect(page).to have_content "Edit list name"
  expect(page).to have_content "Delete list"
end
