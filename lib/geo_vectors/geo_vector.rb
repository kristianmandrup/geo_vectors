require 'geo_calc'
require 'geo_vectors/core_ext'
require 'geo_vectors/util'

# A Vector consists of info that can transform a point into a destination point given some operation on that info  
class GeoVector
  attr_reader :unit  

  def initialize
    @unit = :degrees
  end

  def add! vector
    raise '#add! method must be implemented by including class'
  end

  def scale! scalar
    raise '#scale! method must be implemented by including class'
  end

  def direction
    raise '#distance method must be implemented by including class'
  end

  def distance
    raise '#distance method must be implemented by including class'
  end

  def add vector
    self.dup.add! vector
  end
  
  alias_method :<<, :add
  alias_method :+,  :add

  def sub! vector
    add! vector.reverse
  end

  def sub vector
    self.dup.sub vector
  end
  alias_method :-,  :sub
  
  def scale scalar
    self.dup.scale! scalar
  end      
  alias_method :*,  :scale

  def / scalar
    scale (1.0 / scalar)
  end
  alias_method :reduce, :/    
end
