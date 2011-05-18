require 'geo_vectors/geo_vector'
require 'proxy_party'

class PointVector
  include GeoVector
  # The vector from the origin O = (0,0) to the point A = (2,3) is simply written as (2,3), the unit is degrees.    
  attr_accessor :point

  proxy :point
  
  def initialize *args
    @point = GeoPoint.new *args
  end

  def apply_to arg
    raise ArgumentError, "Argument must be a GeoMagic::Point or a GeoMagic::PointVector" if !arg.any_kind_of?(GeoMagic::Vector, GeoMagic::PointVector)
    case arg
    when GeoMagic::Point
    when GeoMagic::PointVector
    end
  end

  def self.create_at center, vector
    new center, center.move_vector(vector)
  end

  def length type = nil
    rad_dist = case type
    when nil
      GeoMagic::Distance.distance(p0, p1)
    when :latitude
      (p0.latitude - p1.latitude).abs
    when :longitude
      (p0.longitude - p1.longitude).abs
    else
      raise ArgumentError, "Bad argument for calculating lenght, valid args are: nil, :latitude or :longitude"
    end
    d = GeoMagic::Distance.new rad_dist, :radians
    d.lat_factor = p0.middle_point(p1).latitude_factor if type == :latitude 
    d
  end

  def lat_distance
    length(:latitude).in_radians
  end

  def long_distance
    length(:longitude).in_radians
  end

  def vector_distance
    GeoMagic::DistanceVector.new length(:latitude), length(:longitude), :lat_factor => lat_factor
  end        

  # distance between points p0 and p1 that define the vector

  def distance unit = :radians
    dist = ::GeoMagic::Distance.calculate p0, p1
    unit != :radians ? dist[unit] : dist
  end
  
  def distance_from center, unit = :meters
    point = center.move delta_latitude, delta_longitude
    dist = ::GeoMagic::Distance.calculate center, point
    unit != :radians ? dist[unit] : dist
  end

  def [] key
    case key
    when 0, :p0
      p0
    when 1, :p1
      p1
    else
      raise "Vector key must be either 0/1 or :p0/:p1"
    end
  end
  
  protected

  def connection_length 
    Math.sqrt((delta_longitude + delta_latitude).abs)
  end

  def delta_longitude
    (p0.longitude - p1.longitude)**2
  end

  def delta_latitude
    (p0.latitude - p1.latitude)**2
  end            
end

