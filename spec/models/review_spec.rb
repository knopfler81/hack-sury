require 'rails_helper'

describe Review do
  it { should belong_to(:user) }
  it { should belong_to(:trip) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:description) }
end
