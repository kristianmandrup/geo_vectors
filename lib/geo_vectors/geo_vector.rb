require 'geo_vectors/2d_point'
require 'geo_vectors/math'


# Lots of lat/lng calculations
# http://www.movable-type.co.uk/scripts/latlong.html

class GeoVector
  include GeoPoint::AbstractPoint 
  include Math
   
  class << self
    attr_writer :pre_calculate

    def pre_calculate?
      @pre_calculate == true
    end      

    def valid_units
      [:feet, :meters, :kms, :miles, :radians]
    end

    def valid_unit? unit
      valid_units.include? unit
    end

    # The default unit is assumed to be kms
    # This can be changed
    # Example:
    #   GeoVector.default_unit = :km
    
    def default_unit
      @default_unit || :kms
    end

    def default_unit= unit
      @default_unit || :kms
    end
  end

  # A Vector consist of the coordinates (x, y) and is always calculated from the origin (0,0)
  # Each time the vector is updated (either x or y) it should recalculate its distance from origin if the class variable 'precalculate' is set
  # Arguments:
  # - A single GeoPoint
  # - Two GeoPoints p1, p2 : vector calculated as the difference
  # - A GeoDirection : point calculated by applying direction to origin

  attr_reader :unit

  def initialize *args
    last = args.last
    unit = last if last.kind_of?(Symbol)

    if args.size > 1          
      from_points!(*args) if args[1].kind_of? GeoPoint
    else
      return from_direction!(*args) if args.first.kind_of? GeoDirection
      point = GeoPoint.new *args
    end
  end

  def valid_unit? unit
    GeoVector.valid_unit? unit
  end

  def unit= unit
    @unit = unit if valid_unit?(unit)
    recalculate_distance!
  end

  def point
    @point.extend(GeoVector::2DPoint)
  end

  def point= new_point
    @point = new_point
    recalculate_distance!
  end
  
  # The distance of a Vector is the straight line from the origin (0,0 ) to (x,y) 
  # 
  # Returns a GeoDistance (by default in radians)
  def distance unit = :radians
    @distance[unit]
  end

  # Apply vector to point then calculate distance between original point and new point
  def distance_from point, unit = :radians
    new_point = point + self
    distance_between(point, new_point, unit)
  end

  def recalculate_distance!
    return if !GeoVector.pre_calculate?
    @distance = distance_between origin, @point    
  end
  
  protected

  def from_direction! *args
    new origin + args[0]
  end

  def from_points! *args
    p1 = args.first
    p2 = args.last
    @point = GeoPoint.new p2 - p1 # subtracting a point is equivalent to subtracting vector
  end
  
  def origin
    [0,0]
  end
end
