class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout 'mailer'
  before_action :set_locale

  def set_locale
    # TODO fazer o app identificar o locale de alguma forma. Pode ser armazenando o ultimo locale no client.
    I18n.locale = 'pt'
  end

end
