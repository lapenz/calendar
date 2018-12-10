class AppointmentConfirmMailerJob < ApplicationJob
  queue_as :default

  def perform(appointment, type)
    AppointmentsMailer.confirm_appointment(appointment, type).deliver_now if appointment.client.email.present?

  end
end
