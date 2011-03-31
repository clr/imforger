require 'helper'
require 'fileutils'

class TestImforger < MiniTest::Unit::TestCase
  def setup
    @original_file = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', 'large.original.jpg'))
    @input_file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'tmp', 'input.jpg'))
    @output_file = lambda{|type| File.expand_path(File.join(File.dirname(__FILE__), '..', 'tmp', "output.#{type}.jpg"))}

    #prep the files
    raise "Cannot find original file #{@original_file}." unless File.exist?(@original_file)
    FileUtils.cp(@original_file, @input_file)
  end

  def test_raise_an_error_if_no_path_to_file
    assert_raises Imforger::Exception do
      Imforger.new('./this_file_doesnt_exist')
    end
  end

  def test_creates_new_image
    path = @output_file.call('copy')

    fr = Imforger.new @input_file
    fr.to_file path
    assert File.exists?(path)
    assert File.size(path) > 1500000
  end

  def test_creates_new_image_smaller_size
    path = @output_file.call('smaller')

    fr = Imforger.new @input_file
    fr.to_file path, 'width' => 100, 'height' => 100
    assert File.size(path) > 3000
  end

  def test_creates_new_bounded_size
    path = @output_file.call('bounded')

    fr = Imforger.new @input_file
    fr.to_file path, 'maxwidth' => 117, 'maxheight' => 120
    assert File.size(path) > 3900
  end

  def test_creates_new_image_different_format
    path = "#{@output_file.call('format')}.png"

    fr = Imforger.new @input_file
    fr.to_file path, 'format' => 'png'
    assert File.size(path) > 17000000
  end

  def test_raises_an_error_if_unknown_format
    fr = Imforger.new @input_file
    assert_raises Imforger::Exception do
      fr.to_file '/dev/null', 'format' => 'pizza'
    end
  end
end
