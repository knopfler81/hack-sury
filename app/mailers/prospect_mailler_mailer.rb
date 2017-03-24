class ProspectMaillerMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.prospect_mailler_mailer.contact.subject
  #
  def first_contact

        mail(
          to:
          cc:
          subject:  "We will contact you soon!"
        )
  end
