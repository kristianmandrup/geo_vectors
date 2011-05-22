require 'geo_vectors/geo_vector'
require 'sugar-high/kind_of'
require 'proxy_party'

class PointVector
  include GeoVector
  include Add
  include GeoCalc

  attr_accessor :point
  proxy :point
  
  def initialize *args
    args = normalize_points(args[0], args[1]) if args.only_kinds_of?(GeoPoint) && args.size == 2
    @point = GeoPoint.new *args
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

