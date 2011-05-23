require 'geo_vectors/geo_vector'
require 'sugar-high/kind_of'
require 'proxy_party'
require 'geo_vectors/point_vector/vector_ops'
require 'geo_vectors/point_vector/point_ops'

class PointVector < GeoVector
  include GeoCalc
  include VectorOps
  include PointOps

  attr_accessor :point
  proxy :point
  
  def initialize *args
    if args[0].kind_of?(GeoPoint) && args.size == 1
      @point = args[0] 
    else
      args = normalize_points(args[0], args[1]) if args.only_kinds_of?(GeoPoint) && args.size == 2
      @point = GeoPoint.new *args
    end
  end
  
  def point= *args
    @point = GeoPoint.new *args
  end

  def length unit = :kms
    origin.distance_to(point)
  end

  def distance unit = :kms
    origin.distance_to(point).send unit
  end

  def x; lng; end
  def y; lat; end

  def reverse
    self.dup.reverse!
  end

  def reverse!
    self.point.reverse_point!
    self    
  end

  protected

  def normalize_points p1, p2
    lng, lat = [ delta_lat(p1, p2), delta_lng(p1, p2) ]
  end

  def delta_lat p1, p2
    p2.lat - p1.lat
  end

  def delta_lng p1, p2
    p2.lng - p1.lng
  end
  
  def origin
    [0, 0].geo_point
  end
end

