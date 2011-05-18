require 'geo_vectors/geo_vector'

class BearingVector
  include GeoVector
  include GeoDistance::Extract
  include GeoUnits::Converter
  
  attr_reader :bearing
  attr_reader :distance

  # should be Distance objects!
  def initialize brng, dist
    @bearing   = brng
    @distance  = dist
  end      

  # normalize to within 0-360 degrees
  def bearing= brng
    @bearing  = to_deg brng
  end

  def distance= dist
    @distance = extract_distance dist
  end
end
