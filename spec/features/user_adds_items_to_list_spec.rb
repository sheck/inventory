require 'rails_helper'

feature "User adds items to list" do
  scenario "successfully" do
    skip
    fill_in "List name", with: "Working vehicles"
    click_on "Create list"

    expect(list).to have_content "Working vehicles"
    expect(list).to have_content "Stair car"
  end
end
