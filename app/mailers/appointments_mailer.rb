class AppointmentsMailer < ApplicationMailer
  default from: "lucasarthurpenz@gmail.com"

  def check_appointments(client, appointments)
    @client = client
    @appointments = appointments
    mail(to: client.email, subject: "Agendamentos - #{client.company.name}")
  end
end
