# Preview all emails at http://localhost:3000/rails/mailers/appointments_mailer
class AppointmentsMailerPreview < ActionMailer::Preview
  def check_appointments_preview
    AppointmentsMailer.check_appointments(Client.first, Appointment.where(client: Client.first))
  end

  def confirm_appointment_preview
    AppointmentsMailer.appointment_notification(Appointment.first, 'Agendamento confirmado')
  end

  def reprogrammed_appointment_preview
    AppointmentsMailer.appointment_notification(Appointment.first, 'Agendamento reprogramado')
  end

  def cancel_appointment_preview
    AppointmentsMailer.appointment_notification(Appointment.first, 'Agendamento cancelado')
  end

  def remind_appointment_preview
    AppointmentsMailer.appointment_notification(Appointment.first, 'Lembrete de Agendamento')
  end
end
