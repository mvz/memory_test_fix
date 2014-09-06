require 'memory_test_fix/schema_loader'

if defined?(Rails)
  require 'memory_test_fix/railtie.rb'

  if Rails.version =~ /^4\.0\./
    ActiveRecord::Base.class_eval do
      def self.establish_connection(*_)
        super.tap do
          MemoryTestFix::SchemaLoader.init_schema
        end
      end
    end
  end
end
