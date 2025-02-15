c = ENV['COUNTRY']
raise "Environment variable COUNTRY should be set. " if c.nil?

2000.upto(2020) {|y|
  cmd = <<-EOS
gdalwarp -of XYZ -t_srs EPSG:4326 src/#{c}-#{y}.tif /vsistdout | \
YEAR=#{y} COUNTRY=#{c} ruby filter.rb
  EOS
  print cmd
}
