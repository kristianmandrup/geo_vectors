require 'geo_vectors/geo_vector'

class BearingVector
  include GeoVector
  include GeoDistance::Extract
  include GeoUnits::Converter
  
  attr_reader :bearing
  attr_reader :distance

  # should be Distance objects!
  def initialize dist, bearing
    dist, bearing = [bearing, dist] if bearing.kind_of? GeoDistance
    @bearing   = bearing.normalize_deg
    @distance  = extract_distance dist
  end      

  def add_to_point! point
    dest_point = point.destination_point bearing, distance.in_kms
    point.lat = dest_point.lat
    point.lng = dest_point.lng
    point        
  end

  def add_to_point point
    point.destination_point bearing, distance.in_kms
  end

  # normalize to within 0-360 degrees
  def bearing= bearing
    @bearing  = normalize_degrees bearing
  end

  def distance= dist
    @distance = extract_distance dist
  end 
  
  def unit
    distance.unit
  end
  
  def to_s
    "#{distance}, bearing: #{bearing} degrees"
  end
end
