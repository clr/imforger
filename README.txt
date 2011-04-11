= imforger

== DESCRIPTION:

Imforger
[short for Image Forger, because we are making copies of images]

This class relies on the Imlib2 library to quickly convert between different file types, scaling and compressing on the way.

== FEATURES/PROBLEMS:

I have only tested this gem with Linux and Ruby 1.9+  See MAC
INSTALLATION instructions below.

Imlib2 drops the ICC profile and XMP tags when it creates the new image.  I have been using exiftool to copy the ICC profile and XMP tags over.  This is still much faster than ImageMagick et al.

== SYNOPSIS:

require 'imforger'
Imforger.new(input_file_path).to_file(output_file_path)

or:

Imforger.new(input_file_path).to_file(output_file_path, :width => 100,
:height => 100)

or:

Imforger.new(input_file_path).to_file(output_file_path, :maxwidth => 1000,
:maxheight => 1000, :format => 'tif')

See the test file for other examples.

== REQUIREMENTS:

Imlib2

== INSTALL:

gem install imforger

== SPEED:

The purpose of this gem is to scale images and save them out quickly.  ImageMagick was too slow and used too much memory.  [I didn't even bother frobnicating with RMagick.]  I include a benchmark that I used in the benchmark dir.  Results belew.  I also compared to the NetPBM library for good measure.

$ ruby benchmark/benchmark.rb

                  user     system      total        real
ImageMagick   0.000000   0.010000   1.710000 (  0.729113)
NetPBM        0.000000   0.000000   0.700000 (  0.391043)
Imforger      0.310000   0.010000   0.320000 (  0.321695)

Changing the input file size and format showed similar results: Imforger
is roughly twice as fast as calling out ImageMagick in realtime on a
dual-core laptop, and also
noticeably faster than NetPBM.  I don't include memory usage numbers
here, but anecdotally I did notice significantly less RAM usage with Imforger vs
ImageMagick.

== MAC INSTALLATION:

The following was contributed by jllamas.  This is how he got the gem
working on his box.

Install imlib2 (used latest version 1.4.4) from here:
http://sourceforge.net/projects/enlightenment/files/imlib2-src/
./configure
make
sudo make install


Install freetype2 (used latest 2.4.4) from here:
http://sourceforge.net/projects/freetype/files/freetype2/
./configure
make
sudo make install

gem install imforger -- --with-opt-include=/usr/X11/include --with-opt-lib=/usr/X11/lib

All of this requires xCode to be installed.

== LICENSE:

(The MIT License)

Copyright (c) 2011 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
