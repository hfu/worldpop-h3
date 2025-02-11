%w{tls tha jpn}.each {|c|
  2000.upto(2020) {|y|
    cmd = <<-EOS
gdalwarp -of XYZ -t_srs EPSG:4326 src/#{c}-#{y}.tif /vsistdout | \
YEAR=#{y} COUNTRY=#{c} ruby filter.rb
    EOS
    print cmd
  }
}
