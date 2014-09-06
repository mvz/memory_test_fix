require File.expand_path('../boot', __FILE__)

require 'rails'
require 'active_record/railtie'
require 'rails/test_unit/railtie'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module Rails40App
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password, :ssn]
  end
end
