require 'geo_vectors/util/geo_distance'

class Fixnum
  include GeoDistance::Unit
end

class Float
  include GeoDistance::Unit
end
  
