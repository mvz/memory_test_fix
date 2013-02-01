require 'minitest/autorun'
require 'minitest/spec'

describe "A Rails 3.0 app using memory_test_fix" do
  it "can run its tests without a real db" do
    Dir.chdir 'fixtures/rails30_app' do
      system(*%w(bundle update)).must_equal true
      system(*%w(bundle exec rake)).must_equal true
    end
  end
end

describe "A Rails 3.2 app using memory_test_fix" do
  it "can run its tests without a real db" do
    Dir.chdir 'fixtures/rails32_app' do
      system(*%w(bundle update)).must_equal true
      system(*%w(bundle exec rake)).must_equal true
    end
  end
end
