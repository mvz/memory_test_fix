require 'spec_helper'

require 'memory_test_fix/schema_loader'

# Avoid needing to load activerecord which wouldn't be loaded manually anyway
# inside a typical Rails environment.
module ActiveRecord
  class Base
    def self.connection_config
      {}
    end
  end
end

module Rails
  def self.root

  end
end

describe MemoryTestFix::SchemaLoader do
  describe '.init_schema' do
    before do
      allow(ActiveRecord::Base).to receive(:connection_config).and_return config
      allow(Rails).to receive(:root).and_return 'the-rails-root'
      allow(Kernel).to receive(:load)
    end

    describe 'when no in-memory database is configured' do
      let(:config) { { database: 'some/file.sqlite3', adapter: 'sqlite3' } }

      it "works" do
        MemoryTestFix::SchemaLoader.init_schema
      end
    end

    describe 'when an in-memory database is configured' do
      let(:config) { { database: ':memory:', adapter: 'sqlite3' } }

      it "works" do
        MemoryTestFix::SchemaLoader.init_schema
      end
    end
  end
end

