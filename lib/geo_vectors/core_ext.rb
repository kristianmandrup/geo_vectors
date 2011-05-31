require 'geo_vectors/util/geo_distance'

class Fixnum
  include GeoDistance::Unit
end

class Float
  include GeoDistance::Unit
end

# Should use sugar-high array ext in the future!
class Array
  def extract(sym)
   map { |e| e.send(sym) }
  end

  def sum
   inject( 0 ) { |sum,x| sum + x }
  end

  def mean
   (size > 0) ? sum.to_f / size : 0
  end 
end  