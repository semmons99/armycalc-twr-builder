require 'haml'
require 'yaml'

# check ruby version to determine which CSV library to use
MAJOR, MINOR, TINY = RUBY_VERSION.split(".").map{|r| r.to_i}
if MAJOR >= 1 and MINOR >= 9
  require 'csv'
else
  require 'fastercsv'
  CSV = FasterCSV
end

# setup constants and create tmp directory
DATA_DIR = File.expand_path(File.dirname(__FILE__) + "/../data")
TMP_DIR  = File.expand_path(File.dirname(__FILE__) + "/../tmp")
CFG_FILE = File.expand_path(ARGV[0])
CFG_DIR  = File.dirname(CFG_FILE)
Dir.mkdir(TMP_DIR)

# read config file
cfg = YAML::load_file(CFG_FILE)

# create info.xml
haml = File.open(File.join(DATA_DIR, "info.haml")).read
xml  = Haml::Engine.new(haml).render(Object.new,
                                     :cfg => cfg)
File.open(File.join(TMP_DIR, "info.xml"), "w").write(xml)

# create units.xml
units   = CSV.read(File.join(CFG_DIR, cfg["units"]), :headers => true)
bonuses = CSV.read(File.join(CFG_DIR, cfg["bonuses"]), :headers => true)
haml = File.open(File.join(DATA_DIR, "units.haml")).read
xml  = Haml::Engine.new(haml).render(Object.new,
                                     :cfg => cfg,
                                     :units => units,
                                     :bonuses => bonuses)
File.open(File.join(TMP_DIR, "units.xml"), "w").write(xml)

# copy media directory to tmp
require 'fileutils'
include FileUtils

if File.exist?(File.join(CFG_DIR, cfg["media"]))
  cp_r(File.join(CFG_DIR, cfg["media"]), TMP_DIR)
end

# copy validator to tmp

if File.exist?(File.join(CFG_DIR, cfg["validator"]))
  cp(File.join(CFG_DIR, cfg["validator"]), TMP_DIR)
end

