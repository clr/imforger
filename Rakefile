require 'rubygems'
require 'psych'
require 'hoe'

class Hoe
  remove_const :RUBY_FLAGS
  RUBY_FLAGS = "-I#{%w(lib ext test).join(File::PATH_SEPARATOR)}"
end

gem 'rake-compiler', '>= 0.4.1'
require "rake/extensiontask"

Hoe.plugin :git, :doofus, :gemcutter

Hoe.spec 'imforger' do
  developer 'Casey Rosenthal', 'clr@port49.com'

  self.history_file      = 'History.txt'
  self.readme_file       = 'README.txt'
  self.testlib           = :minitest

  extra_dev_deps << ['rake-compiler', '>= 0.4.1']

  self.spec_extras = {:extensions => ['ext/imforger/extconf.rb']}

  Rake::ExtensionTask.new "imforger", spec do |ext|
    ext.lib_dir = File.join(*['lib', ENV['FAT_DIR']].compact)
  end
end

Hoe.add_include_dirs('.:lib')

task :test => :compile
