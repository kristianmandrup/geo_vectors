require 'geo_vectors/geo_vector'
require 'geo_vectors/direction_vector/add'

class DirectionVector
  include GeoVector
  include GeoDistance::Extract
  include GeoDirection  
  include Add
  
  attr_reader :direction # direction symbol :N, :S, :SW, etc.
  attr_reader :distance # GeoDistance object

  def initialize dir, dist
    direction = dir
    distance  = dist
  end

  def direction= dir
    raise ArgumentError, "Invalid direction: #{direction}" if !valid_direction? dir
    @direction = get_valid_direction dir
  end

  def distance= dist
    raise ArgumentError, "Invalid direction: #{distance}" if !valid_distance? dist
    @distance = extract_distance dist
  end
end
