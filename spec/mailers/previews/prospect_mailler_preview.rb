# Preview all emails at http://localhost:3000/rails/mailers/prospect_mailler
class ProspectMaillerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/prospect_mailler/contact
  def contact
    ProspectMaillerMailer.contact
  end

end
