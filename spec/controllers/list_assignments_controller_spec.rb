require 'rails_helper'

describe ListAssignmentsController do

  describe "GET #new" do
    it "only displays lists that the item is not currently a part of" do
      user = create(:user)
      item = create(:item, user: user)
      list1 = create(:list, user: user)
      list2 = create(:list, user: user, name: "Music equipment")
      # list3 = create(:list, user: user, name: "Cables")
      create(:list_assignment, item: item, list: list1)
      sign_in_as(user)

      get :new, { item_id: item.id }

      expect(assigns(:lists)).to_not include(list1)
      expect(assigns(:lists)).to include(list2)
      # expect(assigns(:lists)).to include(list3)
    end
  end
  describe "DELETE #destroy" do
    it "only deletes if assignment belongs to user" do
      user1 = create(:user)
      user2 = create(:user)
      item = create(:item, user: user1)
      list = create(:list, user: user1)
      list_assignment = create(:list_assignment, item: item, list: list)
      sign_in_as(user2)

      expect {
        delete :destroy, { id: list_assignment.id }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
