require 'geo_vectors/geo_vector'

class BearingVector < GeoVector
  include GeoDistance::Extract
  include GeoUnits::Converter
  
  attr_reader :bearing
  attr_reader :distance

  # should be Distance objects!
  def initialize dist, bearing
    dist, bearing = [bearing, dist] if bearing.kind_of? GeoDistance
    self.bearing   = bearing
    self.distance  = dist
  end

  def random_vector                             
    BearingVector.new distance.random, random_bearing
  end

  def add_to_point! point
    dest_point = point.destination_point bearing, distance.in_kms
    point.lat = dest_point.lat
    point.lng = dest_point.lng
    point        
  end

  def add_to_point point
    self.dup.add_to_point! point 
  end

  # normalize to within 0-360 degrees
  def bearing= brng
    @bearing  = brng.normalize_degrees
  end

  def distance= dist
    @distance = extract_distance dist
  end 

  def reverse
    self.dup.reverse!
  end

  def reverse!
    reverse_bearing! 
    self    
  end
  
  def unit
    distance.unit
  end
  
  def to_s
    "#{distance}, bearing: #{bearing} degrees"
  end
  
  protected

  def reverse_bearing!
    shift = case bearing
    when 0
      0
    when -360..0
      180
    when 0..360
      -180
    end
    self.bearing = bearing + shift
  end
  
  def random_bearing
    rand(360 * 100)  / 100    
  end  
end
