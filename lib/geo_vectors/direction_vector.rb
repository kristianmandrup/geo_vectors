require 'geo_vectors/geo_vector'

class DirectionVector < GeoVector
  include GeoDistance::Extract
  include GeoDirection
  
  attr_reader :direction # direction symbol :N, :S, :SW, etc.
  attr_reader :distance # GeoDistance object

  def initialize dist, dir
    dist, dir = [dir, dist] if dir.kind_of? GeoDistance
    @distance   = extract_distance dist
    @direction  = get_valid_direction dir
  end

  def random_vector                             
    DirectionVector.new distance.random, random_direction
  end

  def direction= dir
    @direction = get_valid_direction dir
  end

  def distance= dist
    @distance = extract_distance dist
  end
  
  def unit
    distance.unit
  end
    
  def as_bearing_vector 
    to_bearing_vector direction, distance
  end    

  def as_point_vector 
    to_point_vector direction, distance
  end 
  
  # return new point from adding vector to point
  def add_to_point point
    vec = as_bearing_vector
    point.destination_point vec.bearing, vec.distance.in_kms
  end

  # add vector directly to point (destructive update)
  def add_to_point! point
    vec = as_bearing_vector
    dest = point.destination_point vec.bearing, vec.distance.in_kms
    point.lat = dest.lat
    point.lng = dest.lng
    point
  end
     
end
