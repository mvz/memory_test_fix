require File.expand_path('../boot', __FILE__)

require 'rails'
require 'active_record/railtie'
require 'rails/test_unit/railtie'

Bundler.require(*Rails.groups)

module RailsTestApp
  class Application < Rails::Application
  end
end
