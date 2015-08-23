require 'rails_helper'

describe ItemsController do
  it "only shows created items on index" do
    sign_in
    get :index
    expect(assigns(:items).size).to eq(assigns(:items).count)
  end
end
