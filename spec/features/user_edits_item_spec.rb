require 'rails_helper'

feature "User edits item" do
  before do
    user = create(:user)
    @item = create(:item, user: user)
    visit root_path(as: user)
    click_on @item.name
    click_on "Edit"
  end
  scenario "successfully" do
    fill_in "Name", with: "New name"
    fill_in "Description", with: "New description"
    click_on "Update Item"

    expect(page).to have_text "New name"
    expect(page).to have_text "New description"
  end
  scenario "unsuccessfully" do
    fill_in "Name", with: ""
    click_on "Update Item"

    expect(page).to have_content "can't be blank"
    expect(page).to_not have_content @item.name
  end
end
