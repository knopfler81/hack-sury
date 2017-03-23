require 'rails_helper'

describe Destination do
  it { should have_many(:steps) }
end
