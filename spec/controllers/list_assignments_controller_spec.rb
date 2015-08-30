require 'rails_helper'

describe ListAssignmentsController do

  describe "GET #new" do
    it "keeps lists that do not have item added seperate from current lists" do
      user = create(:user)
      item = create(:item, user: user)
      list1 = create(:list, user: user)
      list2 = create(:list, user: user, name: "Music equipment")
      create(:list_assignment, item: item, list: list1)
      sign_in_as(user)

      get :new, { item_id: item.id }

      expect(assigns(:lists)).to_not include(list1)
      expect(assigns(:lists)).to include(list2)
    end
    it "includes current lists seperate from lists that do not have the item" do
      user = create(:user)
      item = create(:item, user: user)
      list1 = create(:list, user: user)
      list2 = create(:list, user: user, name: "Music equipment")
      create(:list_assignment, item: item, list: list1)
      sign_in_as(user)

      get :new, { item_id: item.id }

      expect(assigns(:current_lists)).to_not include(list2)
      expect(assigns(:current_lists)).to include(list1)
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

  describe "POST #create" do
    it "only creates if item belongs to user" do
      user1 = create(:user)
      user2 = create(:user)
      item = create(:item, user: user1)
      list = create(:list, user: user2)
      sign_in_as(user2)

      expect {
        post :create, { item_id: item.id, list_id: list.id }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "only creates if list belogs to user" do
      user1 = create(:user)
      user2 = create(:user)
      item = create(:item, user: user2)
      list = create(:list, user: user1)
      sign_in_as(user2)

      expect {
        post :create, { item_id: item.id, list_id: list.id }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
