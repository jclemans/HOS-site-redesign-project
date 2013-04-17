require 'environment.rb'
require 'rufus/scheduler'

module Scheduler

end

SCHEDULER_LOG = St::Log.new 'logs/scheduler.log'

while 1
  programs = Program.all
  
  # MIN HOUR * * DAYOFWEEK
  
  programs.each do |program|
    SCHEDULER_LOG.write "Scheduling #{program.name}"
    
    scheduler.cron "#{program.start_minute} #{program.start_hour} * * #{program.day_of_week}" do
      SCHEDULER_LOG.write "Recording #{program.name}"
      puts "STARTING SHOW #{program.name} AT #{Time.now}"
      # show = program.shows.create :when => Time.now
      # system("(streamripper #{STREAM_URL} -A -l #{((program.end_time - program.start_time) + 120).to_i} -i -m 600 -a #{show.file} ; ruby script/finish_stream.rb #{show.id}) &")
    end
  end

end

#scheduler.join
