module MemoryTestFix
  # Set up for use with Rails
  class Railtie < ::Rails::Railtie
    config.after_initialize do
      MemoryTestFix::SchemaLoader.init_schema
    end
  end
end
