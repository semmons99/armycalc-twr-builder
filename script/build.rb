require 'archive/tar/minitar'
include Archive::Tar

# setup constants and create twr directory
TWR_DIR  = File.expand_path(File.dirname(__FILE__) + "/../twr")
TMP_DIR  = File.expand_path(File.dirname(__FILE__) + "/../tmp")
CFG_FILE = File.expand_path(ARGV[0])
Dir.mkdir(TWR_DIR)
Dir.chdir(TMP_DIR)

# read config file
cfg = YAML::load_file(CFG_FILE)

# create twr file
File.open(File.join(TWR_DIR, "#{cfg['ruleset'].gsub(/ /, '-')}-#{cfg['name'].gsub(/ /, '-')}.twr"), "wb") do |twr|
  files = Dir.glob(TMP_DIR + "/*").map{|f| File.basename(f)}
  Minitar.pack(files, twr)
end
