module AppointmentsHelper

  # Will take as input a time in seconds (which is typically a result after subtracting two Time objects),
  # and return the result in HH:MM:SS, even if it exceeds a 24 hour period.
  def formatted_duration(total_seconds)
    Time.at(total_seconds).utc.strftime("%H:%M:%S")
  end
end
