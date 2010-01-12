require 'rake/clean'

CLEAN.include %w( tmp/*.xml tmp/*.lua tmp )
CLOBBER.include %w( twr/*.twr twr )

desc "Generate xml and lua files. Usage: rake generate CONFIG="
task :generate => :clean do
  raise "CONFIG= is required" unless ENV.include?("CONFIG")
  sh "ruby script/generate.rb #{ENV["CONFIG"]}"
end

desc "Build twr file. Usage: rake build CONFIG="
task :build => [:clobber, :generate] do
  raise "CONFIG= is required" unless ENV.include?("CONFIG")
  sh "ruby script/build.rb"
end
