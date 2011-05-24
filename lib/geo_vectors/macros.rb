class GeoVector
  module Macros
    def point_vector
      PointVector.new self.geo_point
    end
    alias_method :geo_vector, :point_vector
    alias_method :p_vector, :point_vector
    
    def vector
      GeoVector::Parser.create_vector *self
    end
  end
end

class GeoPoint
  include ::GeoVector::Macros
end

class Hash
  include GeoVector::Macros
end

class String
  include GeoVector::Macros
end

class Array
  include GeoVector::Macros
  
  def to_point
    geo_point
  end
end    

