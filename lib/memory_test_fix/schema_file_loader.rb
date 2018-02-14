module MemoryTestFix
  # Load Rails schema file into in-memory database.
  # @api private
  module SchemaFileLoader
    # Load the Rails schema file.
    def self.load_schema
      load "#{Rails.root}/db/schema.rb"
    end
  end
end
