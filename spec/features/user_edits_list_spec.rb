require 'rails_helper'

feature "User edits list" do
  scenario "sucessfully" do
    user = create(:user)
    list = create(:list, user: user)
    visit root_path(as: user)
    click_on "Lists"
    click_on list.name

    click_on "Edit list name"
    fill_in "Name", with: "This is the new list name"
    click_on "Update List"

    expect(page).to have_content "This is the new list name"
  end
  scenario "unsuccessfully" do
    user = create(:user)
    list = create(:list, user: user)
    visit root_path(as: user)
    click_on "Lists"
    click_on list.name

    click_on "Edit list name"
    fill_in "Name", with: ""
    click_on "Update List"

    expect(page).to have_content "can't be blank"
    expect(page).to_not have_content list.name
  end
end
