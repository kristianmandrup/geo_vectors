require 'geo_vectors/geo_vector'

class BearingVector
  include GeoVector
  include GeoDistance::Extract
  
  attr_reader :bearing
  attr_reader :distance

  # should be Distance objects!
  def initialize brng, dist
    bearing   = brng
    distance  = dist
  end      

  def bearing= brng
    @bearing  = bearing.to_deg    
  end

  def distance= dist
    @distance = extract_distance dist
  end

  def * arg
    multiply arg
  end

  def / arg
    multiply(1/arg)
  end

  def multiply arg
    vect_dist = new lat_distance.clone, long_distance.clone
    vect_dist.multiply! arg
  end

  def multiply! arg
    factors = case arg
    when Numeric
      [arg, arg]
    when Hash
      [factor(arg, lat_symbols), factor(arg, long_symbols)]
    else
      raise ArgumentError, "Argument must be a Fixnum or a Hash specifying factor to multiply latitude and/or longitude with, was #{arg.class}"
    end      
    multiply_lat factors.first
    multiply_long factors.last
    self
  end

  def radius center
    GeoMagic::Radius.send :"create_rectangular", center, self
  end
end
