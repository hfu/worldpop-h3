require 'h3'
NODATA = -99999.0
RES_MIN = 6
RES_MAX = 9 #10
year = ENV['YEAR']
country = ENV['COUNTRY']

while gets
  r = $_.strip.split(' ').map{|v| v.to_f}
  (lng, lat, pop) = r
  next if pop == NODATA
  RES_MIN.upto(RES_MAX) {|res|
    h3 = H3.from_geo_coordinates([lat, lng], res)
    print [country, year, h3, pop].join(" "), "\n"
  }
end
