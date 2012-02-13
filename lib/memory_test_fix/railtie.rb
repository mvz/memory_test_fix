module MemoryTestFix
  class Railtie < ::Rails::Railtie
    config.after_initialize do
      MemoryTestFix::SchemaLoader.init_schema
    end
  end
end
