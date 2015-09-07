Rails.application.configure do
  config.eager_load = false
  config.active_support.test_order = :random
  config.active_support.deprecation = :stderr
end
