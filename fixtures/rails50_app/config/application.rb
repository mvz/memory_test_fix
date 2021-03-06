require_relative 'boot'

require 'rails'
require 'active_record/railtie'
require 'rails/test_unit/railtie'

Bundler.require(*Rails.groups)

module RailsTestApp
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
  end
end
