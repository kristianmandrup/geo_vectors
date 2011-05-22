require 'geo_vectors/geo_vector'
require 'geo_vectors/direction_vector/add'

class DirectionVector
  include GeoVector
  include GeoDistance::Extract
  include GeoDirection
  include Add
  
  attr_reader :direction # direction symbol :N, :S, :SW, etc.
  attr_reader :distance # GeoDistance object

  def initialize dist, dir
    dist, dir = [dir, dist] if dir.kind_of? GeoDistance
    @distance   = extract_distance dist
    @direction  = get_valid_direction dir
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
end
