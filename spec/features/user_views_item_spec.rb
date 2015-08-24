require 'rails_helper'

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
