require 'archive/tar/minitar'
include Archive::Tar

TWR_DIR  = File.expand_path(File.dirname(__FILE__) + "/../twr")
TMP_DIR = File.expand_path(File.dirname(__FILE__) + "/../tmp")

Dir.mkdir(TWR_DIR)
Dir.chdir(TMP_DIR)

File.open(File.join(TWR_DIR, "WH40K-5E-Space-Wolves.twr"), "wb") do |twr|
  files = Dir.glob(TMP_DIR + "/*").map{|f| File.basename(f)}
  Minitar.pack(files, twr)
end
