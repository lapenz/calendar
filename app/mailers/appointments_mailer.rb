class AppointmentsMailer < ApplicationMailer

  def check_appointments(client, appointments)
    @client = client
    @appointments = appointments
    mail(from: "#{appointment.company.name}", to: client.email, subject: "Agendamentos")
  end

  def appointment_notification(appointment, title)
    @appointment = appointment
    @title = title
    mail(from: "#{appointment.company.name}", to: appointment.client.email, subject: "#{title}")

  end


end
