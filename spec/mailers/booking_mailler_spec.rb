require "rails_helper"

RSpec.describe BookingMaillerMailer, type: :mailer do
  describe "booking_confirmation" do
    let(:mail) { BookingMaillerMailer.booking_confirmation }

    it "renders the headers" do
      expect(mail.subject).to eq("Booking confirmation")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
