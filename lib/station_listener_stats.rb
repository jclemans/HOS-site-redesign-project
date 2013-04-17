require 'rubygems'
require 'nokogiri'
require 'open-uri'

module Station
  module ListenerStats
    def self.start!
      Rufus::Scheduler.start_new.cron('*/10 * * * *') do 
        ListenerStat.create :program => Program.current, :listeners => Nokogiri::HTML(open(STREAM_STATS_PAGE)).css('.streamdata')[5].content
      end
    end
  end
end
