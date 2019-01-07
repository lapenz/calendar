class AppointmentConfirmMailerJob < ApplicationJob
  queue_as :default

  def perform(appointment, title)
    AppointmentsMailer.appointment_notification(appointment, title).deliver_now if appointment.client.email.present?
    NotificationHelper.send_sms(appointment.client.phone, "#{title} em #{appointment.company.name}: #{I18n.localize(appointment.start, format: :long)}") if Rails.env.production?

  end
end
