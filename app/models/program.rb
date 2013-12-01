class Program < ActiveRecord::Base
  has_many :shows, -> {where(is_finished: true).order("id DESC")}, dependent: :destroy
  accepts_nested_attributes_for :shows, allow_destroy:  true

  #has_many :listner_stats
  has_attached_file :avatar, styles: {huge: '600x600', large: '400x400', medium: '200x200', thumb: '50x50'} 

  validate :deejays, present: true

  scope :active, -> {where is_active: true}

  def amazon_thumbnail_sizes
    {:huge => '600x600>', :large => '400x400>', :medium => '200x200>', :thumb => '50x50>'}
  end
 
  def self.all_ordered_by_start
    programs = []
    Date::DAYNAMES.each_index {|index| programs << self.all_for_day(index) }
    programs.flatten
  end
 
  def self.all_active
    all :is_active => true
  end
  
  def self.current
    time = Time.now
    current_time_in_seconds = (time.hour * 60 * 60) + (time.min * 60)
    programs = Program.all :day_of_week => time.strftime('%w'), :is_active => true
    programs.each do |program|
      return program if current_time_in_seconds >= program.start_time_in_seconds && current_time_in_seconds < program.end_time_in_seconds
    end
    nil
  end
  
  def self.all_for_day(day_of_week, options = {})
    self.all({:day_of_week => day_of_week.to_i, :order => [:start_hour,:start_minute]}.merge(options))
  end
  
  def start_time_in_seconds
    (start_hour.to_i * 60 * 60) + (start_minute.to_i * 60)
  end
  
  def end_time_in_seconds

  # Astro added a conditional here to fix a bug that caused
  # shows that end at midnight not to show up on the main page
  # while they were live. See the conditional in def self.current
  # above and consider that current_time_in_seconds is always going
  # to be greater than zero (current_time_in_seconds for midnight).
  # 12/19/2011

    if (end_hour.to_i * 60 * 60) + (end_minute.to_i * 60) != 0
      return (end_hour.to_i * 60 * 60) + (end_minute.to_i * 60)
    else
      return 86399
    end
    nil
  end
  
  def enforce_max_shows
    until shows.length <= MAX_ARCHIVED_SHOWS
      shows.first(:order => [:when]).destroy
      reload
    end
  end
  
  def start_minute=(min)
    write_attribute(:start_minute, min.to_s.rjust(2, '0'))
  end
  
  def end_minute=(min)
    write_attribute(:end_minute, min.to_s.rjust(2,'0'))
  end
  
  def start_time
    parse_time 'start'
  end
  
  def end_time
    parse_time 'end'
  end
  
  def parse_time(which)
    "#{twenty_four_to_twelve which}:#{read_attribute "#{which}_minute"}#{am_or_pm? which}"
  end
  
  def am_or_pm?(which)
    read_attribute("#{which}_hour").to_i < 12 ? 'AM' : 'PM'
  end
  
  def twenty_four_to_twelve(which)
    hour = read_attribute("#{which}_hour").to_i
    return 12 if hour == 0
    hour -= 12 if hour > 12
    hour
  end
end
