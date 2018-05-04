module AppointmentsHelper

  # Will take as input a time in seconds (which is typically a result after subtracting two Time objects),
  # and return the result in HH:MM:SS, even if it exceeds a 24 hour period.
  def formatted_duration(total_seconds)
    hours = total_seconds / (60 * 60)
    minutes = (total_seconds / 60) % 60
    seconds = total_seconds % 60
    [hours, minutes, seconds].map do |t|
      # Right justify and pad with 0 until length is 2.
      # So if the duration of any of the time components is 0, then it will display as 00
      t.round.to_s.rjust(2,'0')
    end.join(':')
  end
end
