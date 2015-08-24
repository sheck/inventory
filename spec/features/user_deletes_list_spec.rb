require 'rails_helper'
include ActionView::RecordIdentifier

feature "User deletes list" do
  scenario "successfully from the list page" do
    user = create(:user)
    list = create(:list, user: user)
    visit root_path(as: user)
    click_on "Lists"

    click_on list.name
    click_on "Delete"

    expect(page).to have_content "successfully deleted"
    expect(page).to_not have_content list.name
  end
  scenario "successfully from the list index" do
    user = create(:user)
    list = create(:list, user: user)
    visit root_path(as: user)
    click_on "Lists"

    within "##{dom_id(list)}" do
      click_on "Delete"
    end

    expect(page).to have_content "successfully deleted"
    expect(page).to_not have_content list.name
  end
end
