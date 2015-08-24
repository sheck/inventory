require 'rails_helper'

describe List do
  it { should belong_to(:user) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user) }
  it { should have_many(:list_assignments) }
  it { should have_many(:items).through(:list_assignments) }
end
