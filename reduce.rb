require 'h3'
require 'json'

dict = Hash.new {|h0, h3|
  h0[h3] = Hash.new {|h1, year|
    h1[year] = 0.0
  }
}

count = 0
while gets
  count += 1
  (country, year, h3, pop) = $_.strip.split(' ')
  year = year.to_i
  h3 = h3.to_i
  pop = pop.to_f
  dict[h3][year] += pop
  $stderr.print "#{Time.now} #{country} #{year} #{dict.size}\n" if count % 10000000 == 0
end

dict.keys.each {|h3|
  res = H3.resolution(h3)
  coords = H3.to_boundary(h3)
  coords.size.times {|i| coords[i] = coords[i].reverse}
  coords.push(coords[0])
  f = {
    :type => 'Feature',
    :geometry => {
      :type => 'Polygon',
      :coordinates => [coords]
    },
    :properties => dict[h3].map {|k,v| [k, v.round]}.to_h,
    :tippecanoe => {
      :layer => 'pop',
      :minzoom => { 5 => 1, 6 => 5, 7 => 8, 8 => 10, 9 => 12, 10 => 14 }[res],
      :maxzoom => { 5 => 4, 6 => 7, 7 => 9, 8 => 11, 9 => 12, 10 => 14 }[res]
    }
  }
  print JSON.dump(f), "\n"
}

