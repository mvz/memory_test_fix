module MemoryTestFix
  # Load database scheme into in-memory database.
  module SchemaLoader
    def self.in_memory_database?
      in_memory? && sqlite3?
    end

    def self.in_memory?
      configuration[:database] == ':memory:' || configuration[:dbfile] == ':memory:'
    end

    def self.sqlite3?
      configuration[:adapter] == 'sqlite3'
    end

    def self.configuration
      ActiveRecord::Base.connection_config
    end

    def self.verbosity
      configuration[:verbosity]
    end

    def self.migrate
      configuration[:migrate] == true
    end

    def self.inform_using_in_memory
      puts "Creating sqlite :memory: database"
    end

    def self.load_schema
      if migrate
        -> { ActiveRecord::Migrator.up('db/migrate') }
      else
        -> { Kernel.load "#{Rails.root}/db/schema.rb" }
      end
    end

    def self.init_schema
      if in_memory_database?
        case verbosity
        when "silent"
          silence_stream(STDOUT, &load_schema)
        when "quiet"
          inform_using_in_memory
          silence_stream(STDOUT, &load_schema)
        else
          inform_using_in_memory
          load_schema.call
        end
      end
    end
  end
end
