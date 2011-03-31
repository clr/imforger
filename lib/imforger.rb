require 'imforger.so'

class Imforger
  VERSION = '0.2.2'

  attr_accessor :input_image, :output_image, :options

  class Exception < RuntimeError; end

  def initialize(path)
    path = File.expand_path(path)

    raise(Imforger::Exception, "Input file not found!") unless File.exists?(path)
    @input_image = path
    @options = {}
  end

  def to_file(output_path, opts = {})
    @options.merge!(opts)
    check_format

    save_file(File.expand_path(output_path))
  end

private
  def check_format
    if @options[:format]
      raise(Imforger::Exception, "I don't know if that file format is supported!") unless %w(tif png jpg).include?(@options[:format])
    end
  end
end
