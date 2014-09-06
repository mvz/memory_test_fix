require 'active_support/core_ext/kernel/reporting'

module MemoryTestFix
  # Load database scheme into in-memory database.
  class SchemaLoader
    def self.init_schema
      new.init_schema
    end

    def initialize(options = {})
      @configuration = options[:configuration] || ActiveRecord::Base.connection_config
      @migrator = options[:migrator] || ActiveRecord::Migrator
      @loader = options[:loader] || ActiveRecord::Tasks::DatabaseTasks
    end

    def init_schema
      return unless in_memory_database?

      inform_using_in_memory unless silent?

      if silent? || quiet?
        load_schema_silently
      else
        load_schema
      end
    end

    private

    def in_memory_database?
      in_memory? && sqlite3?
    end

    def in_memory?
      @configuration[:database] == ':memory:' || @configuration[:dbfile] == ':memory:'
    end

    def sqlite3?
      @configuration[:adapter] == 'sqlite3'
    end

    def verbosity
      @configuration[:verbosity]
    end

    def silent?
      verbosity == "silent"
    end

    def quiet?
      verbosity == "quiet"
    end

    def migrate
      @configuration[:migrate] == true
    end

    def inform_using_in_memory
      puts "Creating sqlite :memory: database"
    end

    def load_schema
      if migrate
        @migrator.up('db/migrate')
      else
        @loader.load_schema
      end
    end

    def load_schema_silently
      silence_stream STDOUT do
        load_schema
      end
    end
  end
end
