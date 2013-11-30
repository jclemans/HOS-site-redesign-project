module ProgramsHelper
  def two_digit_hours
    %w{00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23}
  end

  def two_digit_minutes
    %w{00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 
    27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53
    54 55 56 57 58 59}
  end

  def hour_24_to_12 hour
    meridiem = (hour < 12 ? 'AM' : 'PM')
    hour = (hour == 0 ? '12' : (hour > 12 ? hour-12 : hour))
    "#{hour}#{meridiem}"
  end

  def show_link show
    "/shows/#{show.id}/House of Sound - #{strip_non_characters(show.program.name)} - #{show.when.strftime("%B %d")}.mp3"
  end

  def strip_non_characters string
    string.gsub(/['.,]/, '').gsub(/[^a-z0-9]+/i, ' ')
  end
end
