require 'helper'
require 'fileutils'

class TestImforger < MiniTest::Unit::TestCase
  def setup
    @original_file = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', 'large.original.jpg'))
    @input_file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'tmp', 'input.jpg'))
    @output_file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'tmp', "output.jpg"))

    #prep the files
    raise "Cannot find original file #{@original_file}." unless File.exist?(@original_file)
    FileUtils.cp(@original_file, @input_file)
  end

  def teardown
    FileUtils.rm @input_file
#    FileUtils.rm @output_file
  end

  def test_raise_an_error_if_no_path_to_file
    assert_raises Imforger::Exception do
      Imforger.new('./this_file_doesnt_exist')
    end
  end

  def test_creates_new_image
    fr = Imforger.new @input_file
    fr.to_file @output_file
    assert File.exists?(@output_file)
  end
end
