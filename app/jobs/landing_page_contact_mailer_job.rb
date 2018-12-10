class LandingPageContactMailerJob < ApplicationJob
  queue_as :default

  def perform(name, email, message)
    LandingPageMailer.contact(name, email, message).deliver_now

  end
end
