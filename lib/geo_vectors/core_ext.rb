require 'geo_vectors/util/geo_distance'

class Fixnum
  include GeoDistance::Unit
end

class Float
  include GeoDistance::Unit
end

module GeoVector::Macros
  def point_vector
    PointVector.new self.geo_point
  end
  alias_method :vector, :point_vector
end

class Array
  include GeoVector::Macros

  def b_vector
    raise ArgumentException, "To create a BearingVector, the Array must contain at least 2 elements, one for bearing and oen for distance" if !size >= 2
    BearingVector.new self[0], self[1]
  end  

  def d_vector
    raise ArgumentException, "To create a DirectionVector, the Array must contain at least 2 elements, one for bearing and oen for distance" if !size >= 2
    raise ArgumentException, "The second element in the Array must be a Symbol defining the direction of the vector" if !self[1].kind_of?(Symbol)
    DirectionVector.new self[0], self[1]
  end  
end    
  
