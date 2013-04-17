# thin start -p 4567 -R config.ru
# thin start -p 4567 -e production -R config.ru

ENV['RACK_ENV'] ||= 'development'
require 'environment'

SCHEDULER = Station::Archiver.new Program.all_active, File.join('logs', 'archiver.log')

map '/' do
  run App
end

map '/admin' do
  run Admin
end