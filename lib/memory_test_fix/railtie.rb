module MemoryTestFix
  class Railtie < ::Rails::Railtie
    config.before_eager_load do
      MemoryTestFix::SchemaLoader.init_schema
    end
  end
end
