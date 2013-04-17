$KCODE = "UTF8"
TIMEZONE = 'US/Pacific'
ENV['TZ'] = TIMEZONE
STREAM_BASE_URL = 'http://www.houseofsound.org:8000/'
STREAM_STATS_PAGE = "#{STREAM_BASE_URL}status.xsl"
STREAM_URL = "#{STREAM_BASE_URL}live.mp3.m3u"
DIRECT_STREAM_URL = "#{STREAM_BASE_URL}live.mp3"
MAX_ARCHIVED_SHOWS = 5
ADMIN_USER = 'admin'
ADMIN_PASS = 'glass3phone'
TIMESTAMP = Time.now.to_i
ADMIN_TO_EMAIL = 'admins@houseofsound.org'

ADMIN_CC_EMAILS = ''

ENV['RACK_ENV'] ||= 'development'
LOCAL_MUSIC_FOLDER = ENV['RACK_ENV'].to_sym == :production ? '/home/houseofsound/localmusic' : './'

require 'rubygems'
require 'jcode'
require 'logger'

require "bundler"
Bundler.setup
Bundler.require :default

Dir.glob(File.join('lib', '*.rb')).each { |f| require f }
Dir.glob(File.join('models', '*.rb')).each { |f| require f }
Dir.glob(File.join('gems', '*')).each do |gem_folder|
  $LOAD_PATH.unshift File.join(File.expand_path(File.dirname(__FILE__)), gem_folder, 'lib')
end

case ENV['RACK_ENV']
when 'development'
  puts 'Starting in development mode..'
  
  ACCESS_LOG = STDOUT
  
  DataMapper::Logger.new(STDOUT, :debug)
  DataMapper.setup(:default, 'mysql://houseofsound:f33l1t@localhost/houseofsound_development')
  
when 'production'
  puts 'Starting in production mode..'
  APP_LOG = File.new File.join('logs', 'app.log'), 'a'
  ACCESS_LOG = File.new File.join('logs', 'access.log'), 'a'
#  STDOUT.reopen APP_LOG
#  STDERR.reopen APP_LOG
 
  DataMapper.setup :default, "mysql://houseofsound:947SucksDick@localhost/houseofsound"
  Station::ListenerStats.start!
else
  raise 'Configuration not found for this environment.'
end

Sinatra::Base.use Rack::ShowExceptions # if ENV['RACK_ENV'] == 'development'
Sinatra::Base.use Rack::MethodOverride
Sinatra::Base.use Rack::Session::Cookie, :key => 'app.session',
                           :path => '/',
                           :expire_after => 2592000, # In seconds
                           :secret => 'FDJFDSFEIJEIWFIEOWJ'
=begin
Sinatra::Base.use Rack::MobileDetect, 
                  :targeted => /iPhone/,
                  :redirect_map => { 'iPhone' => '/iphone' }
=end

Sinatra::Base.set :static, true
Sinatra::Base.set :root, File.expand_path(File.dirname(__FILE__))
Sinatra::Base.set :public, File.join(Sinatra::Base.root, 'static')
Sinatra::Base.set :dump_errors, true
Sinatra::Base.set :reload_templates, true
# Sinatra::Base.set :show_exceptions, true

require 'app'
require 'admin'
require 'app_helpers'

Sinatra::Base.helpers Sinatra::AppHelpers
Linguistics::use :en
