require 'rails_helper'

describe ItemsController do

  describe "GET #index" do
    it "does not display the item from item.new" do
      sign_in
      get :index
      expect(assigns(:items).size).to eq(assigns(:items).count)
    end
  end

  describe "DELETE #destroy" do
    it "only deletes if the item belongs to the user" do
      user = create(:user)
      item = create(:item, user: user)
      user2 = create(:user, email: "user2@example.com")
      sign_in_as(user2)

      expect {
        delete :destroy, {:id => item.to_param}
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
