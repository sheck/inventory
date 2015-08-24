require 'rails_helper'

describe ListAssignment do
  it { should belong_to(:item) }
  it { should belong_to(:list) }
  it { should validate_presence_of(:item) }
  it { should validate_presence_of(:list) }
end
