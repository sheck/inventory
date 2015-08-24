require 'rails_helper'
include ActionView::RecordIdentifier

feature "User adds items to list" do

  scenario "from item index" do
    @user = create(:user)
    @item = create(:item, name: "Stair car", user: @user)
    @list = create(:list, name: "Working vehicles", user: @user)
    visit root_path(as: @user)

    within "##{dom_id(@item)}" do
      click_on "Add to list"
    end
    click_on "Working vehicles"

    expect(page).to have_content "Working vehicles"
    expect(page).to have_content "Stair car"
    expect_page_to_be_list_show
  end

  scenario "from item page" do
    @user = create(:user)
    @item = create(:item, name: "Stair car", user: @user)
    @list = create(:list, name: "Working vehicles", user: @user)
    visit root_path(as: @user)
    click_on @item.name

    click_on "Add to list"
    click_on "Working vehicles"

    expect(page).to have_content "Working vehicles"
    expect(page).to have_content "Stair car"
    expect_page_to_be_list_show
  end

  scenario "from list page" do
    @user = create(:user)
    @item = create(:item, name: "Stair car", user: @user)
    @list = create(:list, name: "Working vehicles", user: @user)
    visit root_path(as: @user)
    click_on "Lists"
    click_on @list.name

    within "##{dom_id(@item)}" do
      click_on "Add to list"
    end

    expect(page).to have_content "Working vehicles"
    expect(page).to have_content "Stair car"
    expect_page_to_be_list_show
  end
end

def expect_page_to_be_list_show
  # there has to be a better way to do this
  expect(page).to have_content "Edit list name"
  expect(page).to have_content "Delete list"
end
