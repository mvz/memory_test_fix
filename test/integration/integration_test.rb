require 'test_helper'
require 'yaml'

def in_clean_bundler_environment(*args)
  system(*%w(/usr/bin/env RUBYOPT= BUNDLE_BIN_PATH= BUNDLE_GEMFILE=) + args)
end

def update_bundle(label)
  return if in_clean_bundler_environment(*%w(bundle update --quiet --local))
  puts "Starting remote update of the bundle for #{label}"
  return if in_clean_bundler_environment(*%w(bundle update))
  raise "Unable to initialize test environment for #{label}"
end

def run_tests
  result = false
  out, err = capture_subprocess_io do
    result = in_clean_bundler_environment(*%w(bundle exec rake))
  end
  # If the command failed, make it print any error messages
  err.must_equal "" unless result
  out
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

def create_db_config_without_migrations
  File.open 'config/database.yml', 'w' do |f|
    f.puts YAML.dump(BASE_CONFIG)
  end
end

def create_db_config_with_migrations
  File.open 'config/database.yml', 'w' do |f|
    f.puts YAML.dump BASE_CONFIG.merge(test: { migrate: true })
  end
end

VERSIONS = [
  ["Rails 3.2", 'rails32_app'],
  ["Rails 4.0", 'rails40_app'],
  ["Rails 4.1", 'rails41_app'],
  ["Rails 4.2", 'rails42_app'],
]

VERSIONS.each do |label, appdir|
  Dir.chdir "fixtures/#{appdir}" do
    update_bundle label
  end

  describe "A #{label} app using memory_test_fix" do
    it "can run its tests without a real db" do
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
      end
    end
  end
end
