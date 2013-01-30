require 'minitest/autorun'
require 'minitest/spec'

describe "A Rails 3.0 app using memory_test_fix" do
  it "can run its tests without a real db" do
    Dir.chdir 'fixtures/rails30_app'
    system(*%w(bundle update))
    system(*%w(bundle exec rake))
  end
end

describe "A Rails 3.2 app using memory_test_fix" do
  it "can run its tests without a real db" do
    Dir.chdir 'fixtures/rails32_app'
    system(*%w(bundle update))
    system(*%w(bundle exec rake))
  end
end
