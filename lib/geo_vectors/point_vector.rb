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
    [0, 0].geo_point.distance_to(self.point).as(unit)
  end
end

