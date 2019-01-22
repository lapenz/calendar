class LandingPageMailer < ApplicationMailer

  def contact(name, phone, email, message)
    @name = name
    @email = email
    @message = message
    @phone = phone
    mail(to: 'lucasarthurpenz@gmail.com', subject: "Formulário de contato - #{name}")
  end

end
