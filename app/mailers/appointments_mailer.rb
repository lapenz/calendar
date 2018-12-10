class AppointmentsMailer < ApplicationMailer

  def check_appointments(client, appointments)
    @client = client
    @appointments = appointments
    mail(to: client.email, subject: "Agendamentos - #{client.company.name}")
  end

  def confirm_appointment(appointment, type)
    @appointment = appointment
    @type = type
    mail(to: appointment.client.email, subject: "Agendamento #{@type} - #{appointment.company.name}")
  end


end
