require 'helper'

class TestForgery < Minitest::TestCase
  test_raise_an_error_if_no_path_to_file do
    assert_raise Forgery::Exception do
      Forgery.new('./this_file_doesnt_exist')
    end
  end
end
