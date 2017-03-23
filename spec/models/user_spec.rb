require 'rails_helper'

describe User do
  it { should have_many(:passenger_bookings) }
  it { should have_many(:organisator_bookings) }
  it { should have_many(:trips) }
  it { should have_many(:passenger_trips) }
  it { should have_many(:notifications) }

  describe "#age" do
    it "returns the user's age" do
      user = create(:user, birth_date: 20.years.ago)
      user_age = user.age
      expect(user_age).to eq(20)
    end
  end

  describe "#completed_profile" do
    # it "returns true when profile is completed" do
    #   user = create(:user, bio: 'Une jolie bio', nickname: "Toto", birth_date: 20.years.ago, first_name: "John", last_name: "Doe" , avatar: 'une image')

    #   user_complet = user.completed_profile?

    #   expect(user_complet).to  be_truthy
    # end

    it "returns false when profile is not completed" do
      user = create(:user, bio: 'Une jolie bio', nickname: "Toto", birth_date: 20.years.ago, first_name: "", last_name: "" )

      user_not_complet = user.completed_profile?

      expect(user_not_complet).to  be_falsy
    end

  end
end
