require 'archive/tar/minitar'
require 'yaml'
include Archive::Tar

# setup constants and create twr directory
TMP_DIR  = File.expand_path(File.dirname(__FILE__) + "/../tmp")
CFG_FILE = File.expand_path(ARGV[0])
CFG_DIR  = File.dirname(CFG_FILE)
Dir.chdir(TMP_DIR)

# read config file
cfg = YAML::load_file(CFG_FILE)

# create twr file
File.open(File.join(CFG_DIR, "#{cfg['ruleset'].gsub(/ /, '-')}-#{cfg['name'].gsub(/ /, '-')}.twr"), "wb") do |twr|
  files = Dir.glob(TMP_DIR + "/*").map{|f| File.basename(f)}
  Minitar.pack(files, twr)
end
