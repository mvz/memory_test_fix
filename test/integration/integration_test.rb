require 'minitest/autorun'
require 'minitest/spec'

def update_bundle
  system(*%w(bundle update --quiet --local)) || system(*%w(bundle update)) or
    raise "Unable to initialize test environment"
end

describe "A Rails 3.0 app using memory_test_fix" do
  it "can run its tests without a real db" do
    Dir.chdir 'fixtures/rails30_app' do
      update_bundle
      system(*%w(bundle exec rake)).must_equal true
    end
  end
end

describe "A Rails 3.2 app using memory_test_fix" do
  it "can run its tests without a real db" do
    Dir.chdir 'fixtures/rails32_app' do
      update_bundle
      system(*%w(bundle exec rake)).must_equal true
    end
  end
end
