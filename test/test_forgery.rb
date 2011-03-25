require 'helper'

class TestForgery < MiniTest::Unit::TestCase
  def test_raise_an_error_if_no_path_to_file
    assert_raises Forgery::Exception do
      Forgery.new('./this_file_doesnt_exist')
    end
  end
end
