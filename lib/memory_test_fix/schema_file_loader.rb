module MemoryTestFix
  # Load Rails schema file into in-memory database.
  module SchemaFileLoader
    def self.load_schema
      # TODO: Use tooling provided by rails once support for Rails 3 is dropped.
      load "#{Rails.root}/db/schema.rb"
    end
  end
end
