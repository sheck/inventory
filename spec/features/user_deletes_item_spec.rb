require 'rails_helper'
include ActionView::RecordIdentifier

feature "User deletes item" do
  before do
    user = create(:user)
    @item = create(:item, user: user)
    visit root_path(as: user)
  end
  scenario "successfully from the item page" do
    click_on @item.name

    click_on "Delete"

    expect(page).to have_content "successfully deleted"
    expect(page).to_not have_content @item.name
    expect(page).to_not have_content @item.description
  end
  scenario "successfully from the item index" do
    within "##{dom_id(@item)}" do
      click_on "Delete"
    end

    expect(page).to have_content "successfully deleted"
    expect(page).to_not have_content @item.name
    expect(page).to_not have_content @item.description
  end
end
