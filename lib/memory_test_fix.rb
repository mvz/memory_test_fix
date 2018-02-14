require 'memory_test_fix/schema_loader'

if defined?(Rails)
  require 'memory_test_fix/railtie.rb'

  if Rails.version =~ /^5\.2\./
    ActiveRecord::Base.class_eval do
      def self.establish_connection(*_)
        super.tap do
          MemoryTestFix::SchemaLoader.init_schema
        end
      end
    end
  end
end

if defined?(Spring)
  Spring.after_fork do
    MemoryTestFix::SchemaLoader.init_schema
  end
end
