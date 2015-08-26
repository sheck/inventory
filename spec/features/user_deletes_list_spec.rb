require 'rails_helper'
include ActionView::RecordIdentifier

feature "User deletes list" do
  before do
    user = create(:user)
    @list = create(:list, user: user)
    visit root_path(as: user)
    click_on "Lists"
  end
  scenario "successfully from the list page" do
    click_on @list.name
    click_on "Delete"

    expect(page).to have_content "successfully deleted"
    expect(page).to_not have_content @list.name
  end
end
