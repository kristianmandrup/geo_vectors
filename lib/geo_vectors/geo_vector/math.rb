require 'geo_vectors/geo_vector/add'
require 'geo_vectors/geo_vector/scale'
require 'geo_vectors/geo_vector/point_add'

module GeoVector::Math
  def self.included(base)
    base.send :include, Addition
    base.send :include, Scale
    base.send :include, PointAdd
  end
end