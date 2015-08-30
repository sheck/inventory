require 'rails_helper'
include ActionView::RecordIdentifier

feature "User manages lists:" do
  context "User adds items to list" do
    before do
      @user = create(:user)
      @item = create(:item, name: "Stair car", user: @user)
      @list = create(:list, name: "Working vehicles", user: @user)
      visit root_path(as: @user)
    end

    scenario "from item index" do
      within "##{dom_id(@item)}" do
        click_on "Add to list"
      end
      click_on "Working vehicles"

      expect(page).to have_content "Working vehicles"
      expect(page).to have_content "Stair car"
      expect_page_to_be_list_show
    end

    scenario "from item page" do
      click_on @item.name

      click_on "Add to list"
      click_on "Working vehicles"

      expect(page).to have_content "Working vehicles"
      expect(page).to have_content "Stair car"
      expect_page_to_be_list_show
    end

    scenario "from list page" do
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

  context "User creates list" do
    scenario "successfully from lists page" do
      visit lists_path(as: create(:user))

      fill_in "Name", with: "Working vehicles"
      click_on "Create List"

      expect(page).to have_content "Working vehicles"
      expect_page_to_be_list_show
    end

    scenario "unsuccessfully from lists page" do
      visit lists_path(as: create(:user))

      fill_in "Name", with: ""
      click_on "Create List"

      expect(page).to have_content "can't be blank"
      expect(page).to_not have_content "Working vehicles"
    end
  end

  context "User deletes list" do
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

  context "User edits list" do
    before do
      user = create(:user)
      @list = create(:list, user: user)
      visit root_path(as: user)
      click_on "Lists"
      click_on @list.name
      click_on "Edit list name"
    end

    scenario "sucessfully" do
      fill_in "Name", with: "This is the new list name"
      click_on "Update List"

      expect(page).to have_content "This is the new list name"
    end

    scenario "unsuccessfully" do
      fill_in "Name", with: ""
      click_on "Update List"

      expect(page).to have_content "can't be blank"
      expect(page).to_not have_content @list.name
    end
  end

  context "User removes item from list" do
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

  context "User views list" do
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

    scenario "by clicking on list from item show" do
      @item = create(:item, user: @user)
      create(:list_assignment, item: @item, list: @list)
      visit item_path(@item, as: @user)

      click_on @list.name

      expect(page).to have_content @list.name
      expect_page_to_be_list_show
    end
  end

end

def expect_page_to_be_list_show
  # there has to be a better way to do this
  expect(page).to have_content "Edit list name"
  expect(page).to have_content "Delete list"
end
