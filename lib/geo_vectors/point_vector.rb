require 'geo_vectors/geo_vector'
require 'proxy_party'

class PointVector
  include GeoVector
  include Add

  attr_accessor :point
  proxy :point
  
  def initialize *args
    @point = GeoPoint.new *args
  end

  def length unit = :kms
    origin.distance_to(point).as(unit)
  end

  protected
  
  def origin
    [0, 0].geo_point
  end
end

