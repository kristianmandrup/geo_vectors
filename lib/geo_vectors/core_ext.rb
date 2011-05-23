require 'geo_vectors/util/geo_distance'

class Fixnum
  include GeoDistance::Unit
end

class Float
  include GeoDistance::Unit
end

class GeoVector
  module Macros
    def point_vector
      PointVector.new self.geo_point
    end
    alias_method :vector, :point_vector
    alias_method :geo_vector, :point_vector
    alias_method :p_vector, :point_vector
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

  def b_vector
    raise ArgumentException, "To create a BearingVector, the Array must contain at least 2 elements, one for bearing and oen for distance" if !(size >= 2)
    BearingVector.new self[0], self[1]
  end
  alias_method :bearing_vector, :b_vector  

  def d_vector
    raise ArgumentException, "To create a DirectionVector, the Array must contain at least 2 elements, one for bearing and oen for distance" if !(size >= 2)
    raise ArgumentException, "The second element in the Array must be a Symbol defining the direction of the vector" if !self[1].kind_of?(Symbol)
    DirectionVector.new self[0], self[1]
  end  
  alias_method :direction_vector, :d_vector    
  
  def to_point
    geo_point
  end
end    
  
