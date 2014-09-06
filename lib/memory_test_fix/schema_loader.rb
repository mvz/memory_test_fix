require 'active_support/core_ext/kernel/reporting'
require 'active_record'

module MemoryTestFix
  # Load database scheme into in-memory database.
  class SchemaLoader
    def self.init_schema
      new.init_schema
    end

    def initialize(configuration = ActiveRecord::Base.connection_config,
                   migrator = ActiveRecord::Migrator,
                   loader = Kernel)
      @configuration = configuration
      @migrator = migrator
      @loader = loader
    end

    def init_schema
      return unless in_memory_database?

      inform_using_in_memory unless silent?
      if noisy?
        load_schema.call
      else
        silence_stream(STDOUT, &load_schema)
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

    def noisy?
      !silent? && !quiet?
    end

    def migrate
      @configuration[:migrate] == true
    end

    def inform_using_in_memory
      puts "Creating sqlite :memory: database"
    end

    def load_schema
      if migrate
        -> { @migrator.up('db/migrate') }
      else
        -> { @loader.load "#{Rails.root}/db/schema.rb" }
      end
    end
  end
end
