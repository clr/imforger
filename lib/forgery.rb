require 'forgery.so'

class Forgery
  VERSION = '0.1.1'

  attr_accessor :input_image, :output_image

  class Exception < RuntimeError; end

  def initialize(path)
    path = File.expand_path(path)

    raise(Forgery::Exception, "Input file not found!") unless File.exists?(path)
    @input_image = path
  end

  def to_file(output_path)
    save_file(File.expand_path(output_path))
  end
end
