require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module HouseOfSound
  class Application < Rails::Application
    config.time_zone = 'Pacific Time (US & Canada)'

    I18n.enforce_available_locales = false

    config.generators do |g|
      g.template_engine :haml
      g.stylesheets false
      g.test_framework :rspec, fixture: false
    end

  end
end
