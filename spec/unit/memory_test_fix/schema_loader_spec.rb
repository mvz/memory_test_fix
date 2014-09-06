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

    context 'when no in-memory database is configured' do
      let(:config) { { database: 'some/file.sqlite3', adapter: 'sqlite3' } }

      it "outputs nothing" do
        expect { MemoryTestFix::SchemaLoader.init_schema }.to_not output.to_stdout
      end

      it "does not load anything" do
        MemoryTestFix::SchemaLoader.init_schema
        expect(Kernel).to_not have_received :load
      end
    end

    context 'when an in-memory database is configured' do
      let(:config) { { database: ':memory:', adapter: 'sqlite3' } }

      context "with regular verbosity" do
        it "informs the user it is creating an in-memory database" do
          expect { MemoryTestFix::SchemaLoader.init_schema }.
            to output("Creating sqlite :memory: database\n").to_stdout
        end
      end

      context "silence" do
        let(:config) { { database: ':memory:', adapter: 'sqlite3', verbosity: 'silent' } }

        it "outputs nothing" do
          expect { MemoryTestFix::SchemaLoader.init_schema }.
            to_not output.to_stdout
        end
      end
    end
  end
end

