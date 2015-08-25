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
  describe "POST #create" do
    it "only assigns items to lists that belong to current user"
  end
  describe "DELETE #destroy" do
    it "only deletes if assignment belongs to user"
  end
end
