module MemoryTestFix
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
      Rails.configuration.database_configuration[Rails.env].with_indifferent_access
    end

    def self.verbosity
      configuration[:verbosity]
    end

    def self.inform_using_in_memory
      puts "Creating sqlite :memory: database"
    end

    def self.init_schema
      if in_memory_database?
        load_schema = lambda {
          load "#{Rails.root}/db/schema.rb" # use db agnostic schema by default
          #  ActiveRecord::Migrator.up('db/migrate') # use migrations
        }
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