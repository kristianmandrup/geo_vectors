require 'geo_vectors/geo_vector/add'
require 'geo_vectors/geo_vector/scale'

module GeoVector::Math
  def self.included(base)
    base.send :include, Add
    base.send :include, Scale
  end
end