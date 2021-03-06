# frozen_string_literal: true

require 'memory_test_fix/schema_file_loader'
require 'active_record'

module MemoryTestFix
  # Set up database schema into in-memory database.
  class SchemaLoader
    # Initialize the schema for an in-memory database, if it is configured. See
    # the README for details on how to configure Rails to use an in-memory
    # database.
    def self.init_schema
      new.init_schema
    end

    # @param [Hash] options The options to configure this instance of SchemaLoader with.
    # @option options [Hash] :configuration The configuration of the database connection
    # @option options :migrator The migrator to use if configured to use migrations
    # @option options :loader The loader to use if configured to not use migrations
    # @api private
    def initialize(options = {})
      @configuration = options[:configuration] || ActiveRecord::Base.connection_config
      @migrator = options[:migrator] || default_migrator
      @loader = options[:loader] || SchemaFileLoader
    end

    # Initialize the schema for the in-memoray database according to the
    # configuration passed to the constructor.
    # @api private
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
      verbosity == 'silent'
    end

    def quiet?
      verbosity == 'quiet'
    end

    def migrate
      @configuration[:migrate] == true
    end

    def inform_using_in_memory
      puts 'Creating sqlite :memory: database'
    end

    def load_schema
      if migrate
        if rails_52?
          @migrator.up
        else
          @migrator.up('db/migrate')
        end
      else
        @loader.load_schema
      end
    end

    def load_schema_silently
      silently do
        load_schema
      end
    end

    def default_migrator
      if rails_52?
        ActiveRecord::Base.connection.migration_context
      else
        ActiveRecord::Migrator
      end
    end

    def rails_52?
      ActiveRecord.version.segments[0..1] == [5, 2]
    end

    def silently
      tmp_stream = StringIO.new

      original = $stdout
      $stdout = tmp_stream

      yield
    ensure
      $stdout = original
    end
  end
end
