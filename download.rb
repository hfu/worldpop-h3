%w{tls tha jpn}.each {|c|
  2000.upto(2020) {|y|
    cmd = <<-EOS
curl -C - -o src/#{c}-#{y}.tif https://data.worldpop.org/GIS/Population/Global_2000_2020/#{y}/#{c.upcase}/#{c}_ppp_#{y}.tif
    EOS
    print cmd
  }
}

