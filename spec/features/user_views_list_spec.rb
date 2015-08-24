require 'rails_helper'

feature "User views list" do

  before do
    @user = create(:user)
    @list = create(:list, user: @user)
  end

  scenario "by clicking on list from index" do
    visit root_path(as: @user)

    click_on "Lists"
    click_on "Working vehicles"

    expect(page).to have_content(@list.name)
    expect_page_to_be_list_show
  end

  scenario "that does not belong to them" do
    user2 = create(:user, email: "user2@example.com")
    visit root_path(as: user2)

    expect { visit item_path @list }.to raise_error(ActiveRecord::RecordNotFound)
  end

  scenario "by clicking on list from item show"

end

def expect_page_to_be_list_show
  # there has to be a better way to do this
  expect(page).to have_content "Edit list name"
  expect(page).to have_content "Delete list"
end
