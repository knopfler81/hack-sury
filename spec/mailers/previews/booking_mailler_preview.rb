# Preview all emails at http://localhost:3000/rails/mailers/booking_mailler
class BookingMaillerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailler/booking_confirmation
  def booking_confirmation
    BookingMaillerMailer.booking_confirmation
  end

end
