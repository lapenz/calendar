# Preview all emails at http://localhost:3000/rails/mailers/appointments_mailer
class AppointmentsMailerPreview < ActionMailer::Preview
  def check_appointments_preview
    AppointmentsMailer.check_appointments(Client.first, Appointment.where(client: Client.first))
  end
end
