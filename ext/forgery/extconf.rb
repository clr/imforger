require 'mkmf'

raise "This Ruby gem requires the Imlib2 library to do the hard work.  You might install it with `yum install imlib2 imlib2-devel` or some such." unless have_library('Imlib2')

%w(freetype X11 Xext).each do |lib|
  raise "Library #{lib} not found." unless have_library(lib)
end

create_makefile('forgery')
