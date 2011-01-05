module MemoryTestFix
  def self.in_memory_database?
    if (configuration['database'] == ':memory:' or configuration['dbfile'] == ':memory:')
      if ActiveRecord::Base.connection.class == ActiveRecord::ConnectionAdapters::SQLite3Adapter
	return true
      end
    end
    false
  end

  def self.configuration
    Rails.configuration.database_configuration[Rails.env]
  end

  def self.verbosity
    configuration['verbosity']
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

ActiveSupport.on_load(:before_initialize) do
  MemoryTestFix.init_schema
end
