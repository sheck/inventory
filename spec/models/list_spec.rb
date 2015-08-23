require 'rails_helper'

describe List do
  it { should belong_to(:user) }
end
