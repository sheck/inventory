require 'rails_helper'

describe ItemsController do

  describe "GET #index" do
    it "does not display the item from item.new" do
      sign_in
      get :index
      expect(assigns(:items).size).to eq(assigns(:items).count)
    end
  end

  describe "POST #create" do
    it "only creates item and list assignment if list belongs to user" do
      user1 = create(:user)
      user2 = create(:user)
      list = create(:list, user: user1)
      sign_in_as(user2)

      expect {
        post :create, item: attributes_for(:item, user: user2, list_ids: list.id)
      }.to_not change(ListAssignment, :count)
    end
    it "only creates item and list assignment if list belongs to user" do
      user1 = create(:user)
      user2 = create(:user)
      list1 = create(:list, user: user1)
      list2 = create(:list, user: user2)
      sign_in_as(user2)

      expect {
        post :create, item: attributes_for(:item, user: user2, list_ids: [list2.id, list1.id])
      }.to_not change(ListAssignment, :count)
    end
  end

  describe "DELETE #destroy" do
    it "only deletes if the item belongs to the user" do
      user = create(:user)
      item = create(:item, user: user)
      user2 = create(:user, email: "user2@example.com")
      sign_in_as(user2)

      expect {
        delete :destroy, id: item.id
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
