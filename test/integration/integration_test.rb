require 'minitest/autorun'
require 'minitest/spec'

def update_bundle
  system(*%w(bundle update --quiet --local)) || system(*%w(bundle update)) or
    raise "Unable to initialize test environment"
end

def run_tests
  result = false
  out, err = capture_subprocess_io do
    result = system(*%w(/usr/bin/env BUNDLE_GEMFILE= bundle exec rake))
  end
  # If the command failed, make it print any error messages
  unless result
    err.must_equal ""
  end
  out.must_match(/Creating sqlite :memory: database/)
  out.must_match(/initialize_schema_migrations_table/)
  out.must_match(/assume_migrated_upto_version/)
end

describe "A Rails 2.3 app using memory_test_fix" do
  it "can run its tests without a real db" do
    Dir.chdir 'fixtures/rails23_app' do
      update_bundle
      run_tests
    end
  end
end

describe "A Rails 3.0 app using memory_test_fix" do
  it "can run its tests without a real db" do
    Dir.chdir 'fixtures/rails30_app' do
      update_bundle
      run_tests
    end
  end
end

describe "A Rails 3.1 app using memory_test_fix" do
  it "can run its tests without a real db" do
    Dir.chdir 'fixtures/rails31_app' do
      update_bundle
      run_tests
    end
  end
end

describe "A Rails 3.2 app using memory_test_fix" do
  it "can run its tests without a real db" do
    Dir.chdir 'fixtures/rails32_app' do
      update_bundle
      run_tests
    end
  end
end
