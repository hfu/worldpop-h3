require 'h3'
require 'json'

dict = Hash.new {|h0, h3|
  h0[h3] = Hash.new {|h1, year|
    h1[year] = 0.0
  }
}

while gets
  (country, year, h3, pop) = $_.strip.split(' ')
  year = year.to_i
  pop = pop.to_f
  dict[h3][year] += pop
end

dict.keys.each {|h3|
  h3i = h3.to_i(16)
  res = H3.resolution(h3i)
  coords = H3.to_boundary(h3i)
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
      :minzoom => { 6 => 4, 7 => 8, 8 => 10, 9 => 12, 10 => 14 }[res],
      :maxzoom => { 6 => 7, 7 => 9, 8 => 11, 9 => 13, 10 => 14 }[res]
    }
  }
  print JSON.dump(f), "\n"
}

