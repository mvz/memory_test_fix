require 'spec_helper'

require 'memory_test_fix/schema_loader'

RSpec.describe MemoryTestFix::SchemaLoader do
  def silently
    tmp_stream = StringIO.new

    original = $stdout
    $stdout = tmp_stream

    yield
  ensure
    $stderr = original
  end

  describe '#init_schema' do
    let(:migrator) { double(:migrator) }
    let(:loader) { double(:loader) }
    let(:options) { { configuration: config, migrator: migrator, loader: loader } }
    let(:schema_loader) { MemoryTestFix::SchemaLoader.new options }

    before do
      allow(loader).to receive(:load_schema) { puts 'loading schema' }
      allow(migrator).to receive(:up)
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
      let(:base_config) { { database: ':memory:', adapter: 'sqlite3' } }
      let(:config) { base_config }

      it "informs the user it is creating an in-memory database" do
        expect { schema_loader.init_schema }.
          to output(/Creating sqlite :memory: database/).to_stdout
      end

      it "prints the output from the loader" do
        expect { schema_loader.init_schema }.
          to output(/loading schema/).to_stdout
      end

      it "tells the loader to load the schema" do
        silently { schema_loader.init_schema }
        expect(loader).to have_received :load_schema
      end

      context "when configured to use migrations" do
        let(:config) { base_config.merge(migrate: true) }

        it "tells the migrator to run the migrations" do
          silently { schema_loader.init_schema }
          expect(migrator).to have_received :up
        end
      end

      context "when running in quietly" do
        let(:config) { base_config.merge(verbosity: 'quiet') }

        it "informs the user it is creating an in-memory database" do
          expect { schema_loader.init_schema }.
            to output(/Creating sqlite :memory: database/).to_stdout
        end

        it "does not print the output from the loader" do
          expect { schema_loader.init_schema }.
            not_to output(/loading schema/).to_stdout
        end
      end

      context "when running in silence" do
        let(:config) { base_config.merge(verbosity: 'silent') }

        it "outputs nothing" do
          expect { schema_loader.init_schema }.to_not output.to_stdout
        end
      end
    end
  end
end
