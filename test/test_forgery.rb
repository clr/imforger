require 'helper'

class TestForgery < Test::Unit::TestCase
  test "that we raise an error if the input file path doesn't exist" do
		assert_raise Forgery::Exception do
			Forgery.new('./this_file_doesnt_exist')
		end
	end
end
