require 'minitest/autorun'
require 'minitest/spec'

def in_clean_bundler_environment *args
  system *%w(/usr/bin/env RUBYOPT= BUNDLE_BIN_PATH= BUNDLE_GEMFILE=) + args
end

def update_bundle label
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
  unless result
    err.must_equal ""
  end
  out.must_match(/Creating sqlite :memory: database/)
  out.must_match(/initialize_schema_migrations_table/)
  out.must_match(/assume_migrated_upto_version/)
end

VERSIONS = [
  ["Rails 3.0", 'rails30_app'],
  ["Rails 3.1", 'rails31_app'],
  ["Rails 3.2", 'rails32_app']
]

VERSIONS.each do |label, appdir|
  describe "A #{label} app using memory_test_fix" do
    it "can run its tests without a real db" do
      Dir.chdir "fixtures/#{appdir}" do
        update_bundle label
        run_tests
      end
    end
  end
end
