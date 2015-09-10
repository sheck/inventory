require 'rails_helper'

feature "User creates item with a list selected" do
  scenario "successfully" do
    user = create(:user)
    list = create(:list, user: user)
    visit root_path(as: user)
    click_on "Add Item"
    # save_and_open_page

    fill_in "Name", with: "Stair Car"
    check list.name
    click_on "Create Item"

    click_on "Lists"
    click_on list.name
    list_items = find(".list-items")
    expect(list_items).to have_content("Stair Car")
  end
end
