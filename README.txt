= imforger

== DESCRIPTION:

Imforger relies on the Imlib2 library to quickly convert between different file types, scaling and compressing on the way.

== FEATURES/PROBLEMS:

As far as I know, this gem only works on Linux and Ruby 1.9+  Anyone
know how to install the dev files for Imlib2, please let me know.

Imlib2 drops the ICC profile and XMP tags when it creates the new image.  I have been using exiftool to copy the ICC profile and XMP tags over.  This is still much faster than ImageMagick et al.

== SYNOPSIS:

require 'imforger'
Imforger.new(input_file_path).to_file(output_file_path)

== REQUIREMENTS:

Imlib2

== INSTALL:

gem install imforger

== SPEED:

ImageMagick was too slow and used too much memory.  [I didn't even bother frobnicating with RMagick.]  I also compared to the NetPBM library for good measure.

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
