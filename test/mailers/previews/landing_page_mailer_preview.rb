# Preview all emails at http://localhost:3000/rails/mailers/landing_page_mailer
class LandingPageMailerPreview < ActionMailer::Preview

  def contact_preview
    LandingPageMailer.contact('João do Teste', 'joaodoteste@gmail.com', 'Oi, gostaria somente de testar este formulario de contato.')
  end
end
