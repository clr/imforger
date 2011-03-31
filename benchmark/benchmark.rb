require 'imforger'
require 'benchmark'
require 'fileutils'
require 'open3'

Benchmark.bm(12) do |x|
  #test these image scaling methods
  benchmark = [
    :imagemagick,
    :netpbm,
    :imlib
  ]

  @original_file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'test', 'fixtures', 'large.original.jpg'))
  @input_file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'tmp', 'input.jpg'))
  @output_file = lambda{|type| File.expand_path(File.join(File.dirname(__FILE__), '..', 'tmp', "output.#{type}.jpg"))}

  #prep the files
  raise "Cannot find original file #{@original_file}." unless File.exist?(@original_file)
  FileUtils.cp(@original_file, @input_file)

  #silence stupid pnmtojpeg
  $stderr.reopen(File.open('/dev/null','w+'))

  x.report("ImageMagick") do
    `convert #{@input_file} -resize 100x100\! #{@output_file.call('ImageMagick')}`
  end if benchmark.include?(:imagemagick)

  x.report("NetPBM") do
    `/usr/bin/anytopnm #{@input_file} | /usr/bin/pamscale -width 100 -height 100 | /usr/bin/pnmtojpeg > #{@output_file.call('NetPBM')}`
  end if benchmark.include?(:netpbm)

  x.report("Imlib") do
    fr = Imforger.new @input_file
    fr.to_file "#{@output_file.call('Imlib')}", 'width' => 100, 'height' => 100
  end if benchmark.include?(:imlib)

  #cleanup files
  if true  && false
    FileUtils.rm @input_file
    [ 'ImageMagick', 'NetPBM', 'Imforger'].each do |type|
      FileUtils.rm @output_file.call(type)
    end
  end
end
