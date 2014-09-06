require 'spec_helper'

require 'memory_test_fix/schema_loader'

module Rails
  def self.root
  end
end

RSpec.describe MemoryTestFix::SchemaLoader do
  describe '#init_schema' do
    let(:migrator) { double(:migrator) }
    let(:loader) { double(:loader) }

    let(:schema_loader) { MemoryTestFix::SchemaLoader.new(configuration: config,
                                                          migrator: migrator,
                                                          loader: loader) }

    before do
      allow(loader).to receive(:load_schema)
    end

    context 'when no in-memory database is configured' do
      let(:config) { { database: 'some/file.sqlite3', adapter: 'sqlite3' } }

      it "outputs nothing" do
        expect { schema_loader.init_schema }.to_not output.to_stdout
      end

      it "does not load anything" do
        schema_loader.init_schema
        expect(loader).to_not have_received :load_schema
      end
    end

    context 'when an in-memory database is configured' do
      let(:config) { { database: ':memory:', adapter: 'sqlite3' } }

      context "with regular verbosity" do
        it "informs the user it is creating an in-memory database" do
          expect { schema_loader.init_schema }.
            to output("Creating sqlite :memory: database\n").to_stdout
        end
      end

      context "silence" do
        let(:config) { { database: ':memory:', adapter: 'sqlite3', verbosity: 'silent' } }

        it "outputs nothing" do
          expect { schema_loader.init_schema }.
            to_not output.to_stdout
        end

        it "tells the loader to load the schema" do
          schema_loader.init_schema
          expect(loader).to have_received :load_schema
        end
      end
    end
  end
end
