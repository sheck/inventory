require 'rails_helper'

feature "User creates item with quick entry mode" do
  scenario "successfullly" do
    visit root_path(as: create(:user))
    click_on "Add Item"

    check "Quick entry mode"
    fill_in "Name", with: "Stair Car"
    click_on "Create Item"
    fill_in "Name", with: "Frozen Banana"
    click_on "Create Item"

    click_on "Items"

    expect(page).to have_content "Stair Car"
    expect(page).to have_content "Frozen Banana"
  end

  scenario "only shows users own lists" do
    other_user = create(:user)
    other_list = create(:list, user: other_user)
    visit new_item_path(as: create(:user))

    expect(page).to_not have_content(other_list.name)
  end

  context "with a list selected" do
    scenario "successfully" do
      user = create(:user)
      list = create(:list, user: user)
      list2 = create(:list, name: "Very cool list", user: user)
      visit root_path(as: user)
      click_on "Add Item"

      check "Quick entry mode"
      fill_in "Name", with: "Stair Car"
      check list.name
      check list2.name
      click_on "Create Item"
        # Lists should be persisted
          # expect(page).to have_checked_field(list.name)
          # expect(page).to have_checked_field(list2.name)
      fill_in "Name", with: "Frozen Banana"
      click_on "Create Item"

      click_on "Items"
      expect(page).to have_content "Stair Car"
      expect(page).to have_content "Frozen Banana"
    end
  end

  context "from the list page" do
    scenario "succesfully" do
      user = create(:user)
      list = create(:list, user: user)
      visit list_path(list, as: user)
      click_on "Add Item"

      check "Quick entry mode"
      fill_in "Name", with: "Stair Car"
      click_on "Create Item"
      fill_in "Name", with: "Frozen Banana"
      click_on "Create Item"

      click_on "Lists"
      click_on list.name

      expect(page).to have_content "Stair Car"
      expect(page).to have_content "Frozen Banana"
    end
  end
end
