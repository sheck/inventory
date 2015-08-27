require 'rails_helper'
include ActionView::RecordIdentifier

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

feature "User views item" do

  before do
    @user = create(:user)
    @item = create(:item, user: @user)
  end

  scenario "successfully" do
    visit root_path(as: @user)

    click_on @item.name

    expect(page).to have_content @item.name
    expect(page).to have_content @item.description
    # expect(page).to have_content lists_that_item_belongs_to
  end

  scenario "that does not belong to them" do
    user2 = create(:user, email: "user2@example.com")
    visit root_path(as: user2)

    expect { visit item_path @item }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
