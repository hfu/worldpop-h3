c = ENV['COUNTRY']
raise "Environment variable COUNTRY needs to be set." if c.nil?
2000.upto(2020) {|y|
  cmd = <<-EOS
curl --retry 5 -C - -o src/#{c}-#{y}.tif https://data.worldpop.org/GIS/Population/Global_2000_2020/#{y}/#{c.upcase}/#{c}_ppp_#{y}.tif
  EOS
  $stderr.print cmd
  system cmd
}

