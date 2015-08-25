require 'rails_helper'
include ActionView::RecordIdentifier

feature "User removes item from list" do
  scenario "successfully" do
    @user = create(:user)
    @list = create(:list, user: @user)
    @item = create(:item, user: @user)
    create(:list_assignment, item: @item, list: @list)
    visit root_path(as: @user)
    click_on "Lists"
    click_on @list.name

    within "##{dom_id(@item)}" do
      click_on "Remove from list"
    end

    list_items = find('.list-items')
    expect(list_items).to_not have_content(@item.name)
  end
end
