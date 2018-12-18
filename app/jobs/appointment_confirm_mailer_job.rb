class AppointmentConfirmMailerJob < ApplicationJob
  queue_as :default

  def perform(appointment, type)
    AppointmentsMailer.appointment_notification(appointment, type).deliver_now if appointment.client.email.present?

  end
end
