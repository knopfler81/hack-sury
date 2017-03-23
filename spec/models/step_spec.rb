require "rails_helper"

describe Step do
  it { should belong_to(:trip)}
  it { should belong_to(:destination)}
end
