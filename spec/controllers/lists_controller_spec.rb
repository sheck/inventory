require 'rails_helper'

describe ListsController do
  describe "GET #show" do
    it "only displays lists that the item is not currently a part of" do
      user = create(:user)
      list = create(:list, user: user)
      item1 = create(:item, user: user)
      item2 = create(:item, user: user, name: "Banana")
      create(:list_assignment, item: item1, list: list)
      sign_in_as(user)

      get :show, { id: list.id }

      expect(assigns(:other_items)).to_not include(item1)
      expect(assigns(:other_items)).to include(item2)
    end
  end

end
