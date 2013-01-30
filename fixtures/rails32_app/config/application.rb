require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module Rails32App
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password, :ssn]
  end
end
