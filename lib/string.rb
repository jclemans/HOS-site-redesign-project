#class String
#  def url_friendly
#    self.downcase.gsub(/['.,]/, '').gsub(/[^a-z0-9]+/i, '-')
#  end
#  
#  def strip_non_characters
#    self.gsub(/['.,]/, '').gsub(/[^a-z0-9]+/i, ' ')
#  end
#  
#  def to_minute
#    self.length == 1 ? "0#{self}" : self
#  end
#  
#  def hour_24_to_12
#    hour = self.to_i
#    meridiem = (hour < 12 ? 'AM' : 'PM')
#    hour = (hour == 0 ? '12' : (hour > 12 ? hour-12 : hour))
#    "#{hour}#{meridiem}"
#  end
#  
#end
