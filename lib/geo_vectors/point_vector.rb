require 'geo_vectors/geo_vector'
require 'sugar-high/kind_of'
require 'proxy_party'

class PointVector < GeoVector
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

  def add vector
    raise ArgumentException, "The object added must be a GeoVector, was: #{vector}" if !vector.kind_of?(GeoVector)
    case vector
    when PointVector
      add_to_point vector
    else
      GeoVectors.new self, vector
    end
  end
  alias_method :<<, :add
  alias_method :+,  :add

  def add! vector
    raise ArgumentException, "The object added must be a GeoVector, was: #{vector}" if !vector.kind_of?(GeoVector)
    case vector
    when PointVector
      v2 = add_to_point vector
      self.point = v2.to_arr
      self      
    else
      GeoVectors.new self, vector
    end
  end

  def random_vector                             
    lat_max = point.lat.abs
    lng_max = point.lng.abs    
    rand_lat = rand(lat_max * 2) - lat_max
    rand_lng = rand(lng_max * 2) - lng_max
    PointVector.new [rand_lat, rand_lng]
  end

  # return new point from adding vector to point
  def add_to_point point
    dest = point.dup
    dest.lat = lat + point.lat 
    dest.lng = lng + point.lng
    dest
  end

  # add vector directly to point (destructive update)
  def add_to_point! point
    point.lat = lat + point.lat 
    point.lng = lng + point.lng
    point
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

