require 'geo_calc'
require 'geo_vectors/geo_vector/math'
require 'geo_vectors/util'

module GeoVector
  # A Vector consist of the coordinates (x, y) and is always calculated from the origin (0,0)
  # Each time the vector is updated (either x or y) it should recalculate its distance from origin if the class variable 'precalculate' is set
  # Arguments:
  # - A single GeoPoint
  # - Two GeoPoints p1, p2 : vector calculated as the difference
  # - A GeoDirection : point calculated by applying direction to origin

  attr_reader :unit
  
  def add_to_point point
  end
end
