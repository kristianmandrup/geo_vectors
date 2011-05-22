require 'geo_calc'
require 'geo_vectors/core_ext'
require 'geo_vectors/util'

# A Vector consists of info that can transform a point into a destination point given some operation on that info  
class GeoVector
  attr_reader :unit  

  def initialize
    @unit = :degrees
  end
  
  def add vector
    raise '#add method must be implemented by including class'
  end
  alias_method :<<, :add
  alias_method :+,  :add

  def - vector
    add vector.reverse
  end
  
  def scale scalar
    lat = lat * scalar
    lng = lng * scalar
  end      

  def * scalar
    scale scalar
  end 
  alias_method :enhance, :*
  alias_method :grow_by, :*

  def / scalar
    scale (1.0 / scalar)
  end
  alias_method :reduce, :/    
end
