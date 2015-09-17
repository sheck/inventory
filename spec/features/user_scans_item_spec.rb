require 'rails_helper'

feature "User scans item" do
  scenario "successfully" do
    user = create(:user)
    create(:list, name: "Great Books", user: user)
    visit root_path(as: user)
    click_on "Scan"

    attach_file "Barcode", "spec/support/barcode.jpg"
    check "Great Books"
    click_on "Scan Barcode"

    expect(page).to have_content "Seven Men: And the Secret of Their Greatness"
    expect(page).to have_css "img.item-photo"
    item_lists = find ".lists-with-item"
    expect(item_lists).to have_content "Great Books"
  end

  context "with a bad barcode image" do
    scenario "unsuccessfully" do
      user = create(:user)
      visit root_path(as: user)
      click_on "Scan"

      attach_file "Barcode", "spec/support/stair_car.jpg"
      click_on "Scan Barcode"

      expect(page).to have_content "Unable to read barcode"
    end
  end

  context "with an item that is unable from Amazon" do
    scenario "unsuccessfully" do
      user = create(:user)
      visit root_path(as: user)
      click_on "Scan"

      attach_file "Barcode", "spec/support/barcode4.jpg"
      click_on "Scan Barcode"

      expect(page).to have_content "did not find any matches for your request"
    end
  end

  context "without an image" do
    scenario "unsuccessfully" do
      user = create(:user)
      visit root_path(as: user)
      click_on "Scan"

      click_on "Scan Barcode"

      expect(page).to have_content "Barcode image can't be blank"
    end
  end

  scenario "that's not a book" do
    user = create(:user)
    create(:list, name: "Great List", user: user)
    visit root_path(as: user)
    click_on "Scan"

    attach_file "Barcode", "spec/support/barcode3.jpg"
    check "Great List"
    click_on "Scan Barcode"

    expect(page).to have_content "Pandemic"
    # expect(page).to have_css "img.item-photo"
    item_lists = find ".lists-with-item"
    expect(item_lists).to have_content "Great List"
  end

  context "with quick entry enabled" do
    scenario "successfully" do
      user = create(:user)
      create(:list, name: "Great Books", user: user)
      visit root_path(as: user)
      click_on "Scan"

      check "Quick entry mode"
      check "Great Books"
      attach_file "Barcode", "spec/support/barcode.jpg"
      click_on "Scan Barcode"
      # save_and_open_page
          expect(current_url).to start_with(new_scan_url)
        qe_mode_checkbox = find("#scan_quick_entry_mode")
        expect(qe_mode_checkbox).to be_checked
      attach_file "Barcode", "spec/support/barcode2.jpg"
      click_on "Scan Barcode"

        expect(current_url).to start_with(new_scan_url)
      qe_mode_checkbox = find("#scan_quick_entry_mode")
      expect(qe_mode_checkbox).to be_checked
      click_on "Lists"
      click_on "Great Books"
      expect(page).to have_content "Seven Men: And the Secret of Their Greatness"
      expect(page).to have_content "Tübingen"
    end
  end
end
