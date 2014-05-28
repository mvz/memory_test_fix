require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Rails41App
  class Application < Rails::Application
  end
end
