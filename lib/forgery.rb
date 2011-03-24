require 'forgery.so'

class Forgery
	attr_accessor :input_image, :output_image

	class Exception < RuntimeError; end

	def initialize(path)
		path = File.expand_path(path)

		raise(Forgery::Exception, "Input file not found!") unless File.exists?(path)
		@input_image = path
	end
end
