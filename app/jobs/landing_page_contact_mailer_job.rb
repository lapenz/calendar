class LandingPageContactMailerJob < ApplicationJob
  queue_as :default

  def perform(name, phone, email, message)
    LandingPageMailer.contact(name, phone, email, message).deliver_now

  end
end
