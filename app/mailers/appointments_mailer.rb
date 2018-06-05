class AppointmentsMailer < ApplicationMailer

  def check_appointments(client, appointments)
    @client = client
    @appointments = appointments
    mail(to: client.email, subject: "Agendamentos - #{client.company.name}")
  end
end
