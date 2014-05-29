module HOS
  module DateHelpers

    def to_day(number)
      days = { 'Sunday' => 0, 'Monday' => 1, 'Tuesday' => 2, 'Wednesday' => 3, 'Thursday' => 4, 'Friday' => 5, 'Saturday' => 6}
      days.key(number)
    end
  end
end
