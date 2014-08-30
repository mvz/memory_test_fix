require 'test_helper'

class FooTest < ActiveSupport::TestCase
  test "Foos have names" do
    assert_equal 'Foo one', foos(:one).name
  end

  test "Foos can be stored" do
    foo = Foo.new(name: 'A third')
    foo.save!
    assert_equal 'A third', Foo.find(foo.id).name
  end
end
