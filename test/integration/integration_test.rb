require 'test_helper'
require 'yaml'

def in_clean_bundler_environment(*args)
  system(*%w(/usr/bin/env -u RUBYOPT -u BUNDLE_BIN_PATH -u BUNDLE_GEMFILE) + args)
end

def update_bundle(label)
  return if in_clean_bundler_environment(*%w(bundle update --quiet --local))
  puts "Starting remote update of the bundle for #{label}"
  return if in_clean_bundler_environment(*%w(bundle update))
  raise "Unable to initialize test environment for #{label}"
end

def run_tests(command_array = %w(bundle exec rake))
  result = false
  out, err = capture_subprocess_io do
    result = in_clean_bundler_environment(*command_array)
  end
  # If the command failed, make it print any error messages
  err.must_equal "" unless result
  out
end

def stop_spring
  capture_subprocess_io do
    in_clean_bundler_environment(*%w(bin/spring stop))
  end
end

BASE_CONFIG = {
  "development" =>  {
    "adapter" =>  'sqlite3',
    "pool" =>  5,
    "timeout" =>  5000,
    "database" =>  'db/development.sqlite3'
  },
  "test" =>  {
    "adapter" =>  'sqlite3',
    "database" =>  ':memory:'
  }
}

MIGRATING_CONFIG = BASE_CONFIG.dup.tap do |config|
  config["test"] = config["test"].merge("migrate" => true)
end

def create_db_config_without_migrations
  File.open 'config/database.yml', 'w' do |f|
    f.puts YAML.dump(BASE_CONFIG)
  end
end

def create_db_config_with_migrations
  File.open 'config/database.yml', 'w' do |f|
    f.puts YAML.dump(MIGRATING_CONFIG)
  end
end

VERSIONS = [
  ["Rails 4.1", 'rails41_app', false],
  ["Rails 4.2", 'rails42_app', true],
  ["Rails 5.0", 'rails50_app', true],
]

VERSIONS.each do |label, appdir, binstubs|
  Dir.chdir "fixtures/#{appdir}" do
    update_bundle label
  end

  describe "A #{label} app using memory_test_fix" do
    it "can run its tests in-memory without migrations" do
      Dir.chdir "fixtures/#{appdir}" do
        create_db_config_without_migrations
        out = run_tests
        out.must_match(/Creating sqlite :memory: database/)
        out.must_match(/initialize_schema_migrations_table/)
      end
    end

    it "can run its tests in-memory with migrations" do
      Dir.chdir "fixtures/#{appdir}" do
        create_db_config_with_migrations
        out = run_tests
        out.must_match(/Creating sqlite :memory: database/)
        out.wont_match(/initialize_schema_migrations_table/)
      end
    end

    if binstubs
      describe 'when using spring' do
        let(:command_array) { %w(bin/rake) }
        it "can run its tests in-memory without migrations" do
          Dir.chdir "fixtures/#{appdir}" do
            stop_spring
            create_db_config_without_migrations
            out = run_tests command_array
            out.must_match(/Creating sqlite :memory: database/)
            out.must_match(/initialize_schema_migrations_table/)
          end
        end

        it "can run its tests in-memory with migrations" do
          Dir.chdir "fixtures/#{appdir}" do
            stop_spring
            create_db_config_with_migrations
            out = run_tests command_array
            out.must_match(/Creating sqlite :memory: database/)
            out.wont_match(/initialize_schema_migrations_table/)
          end
        end
      end
    end
  end
end
