class LandingPageMailer < ApplicationMailer

  def contact(name, email, message)
    @name = name
    @email = email
    @message = message
    mail(to: 'lucasarthurpenz@gmail.com', subject: "Formulário de contato - #{name}")
  end

end
