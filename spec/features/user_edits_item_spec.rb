require 'rails_helper'

feature "User edits item" do
  scenario "successfully" do
    user = create(:user)
    item = create(:item, user: user)
    visit root_path(as: user)
    click_on item.name

    click_on "Edit"
    fill_in "Name", with: "New name"
    fill_in "Description", with: "New description"
    click_on "Update Item"

    expect(page).to have_text "New name"
    expect(page).to have_text "New description"
  end
end
