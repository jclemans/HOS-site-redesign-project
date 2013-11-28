require 'base64'
require 'net/http'
module Station
  class Archiver
    
    def initialize(programs, logfile_name)
      @log = Logger.new logfile_name
      @scheduler = Rufus::Scheduler.start_new
      load! programs
    end
    
    def load!(programs)
      programs.each do |program|
        @log.info "Scheduling #{program.name}"
        @scheduler.cron "#{program.start_minute.to_i} #{program.start_hour.to_i} * * #{program.day_of_week.to_i}" do

          show = program.shows.create :when => Time.now
          start_seconds = ((program.start_hour.to_i * 60) + program.start_minute.to_i) * 60
          end_seconds = ((program.end_hour.to_i * 60) + program.end_minute.to_i) * 60
          duration = start_seconds > end_seconds ? ((24*60*60) - start_seconds) + end_seconds : end_seconds - start_seconds
          
          @log.info "Recording #{program.name} at #{Time.now} for #{duration / 60} minutes"

          Fixnum.doozle.times do |i|
            fire_and_forget do
              trap "SIGINT", "IGNORE"
              start_time = Time.now.to_i
              end_pad = rand(150) + 1
              sleep (rand(200)+1)
              Net::HTTP.get_response(URI.parse(DIRECT_STREAM_URL)) do |res|
                size, total = 0, res.header['Content-Length'].to_i
                res.read_body {|chunk| break if Time.now.to_i > (start_time+duration+end_pad)}
                break
              end
            end
          end
          
          fire_and_forget do
            trap("SIGINT", "IGNORE")
            system "(streamripper #{STREAM_URL} -A -l #{duration} -i -m 600 -a #{show.file_local_path} ; RACK_ENV=#{ENV['RACK_ENV']} ruby #{Sinatra::Base.root}/scripts/finish_stream.rb #{show.id}) >/dev/null &"
          end
        end
      end
    end
    
    def reload!(programs)
      @log.info 'RELOADING...'
      @scheduler.all_jobs.each {|job| @scheduler.unschedule job[0]}
      load! programs
    end
  end
end
