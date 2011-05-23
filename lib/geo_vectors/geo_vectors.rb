# Operations that apply on a collection of GeoVector
class GeoVectors < Array
  include Enumerable
  # include GeoVector
  attr_reader :vectors

  def initialize *vectors
    self.vectors = vectors
  end

  def vectors= *vectors
    vectors = vectors.flatten
    raise ArgumentError, "GeoVectors can only contain GeoVector instances" if !vectors.only_kinds_of? GeoVector
    @vectors = vectors
  end

  def each
    vectors.each { |v| yield v }
  end

  # return new point from adding vector to point
  def add_to_point point
    add_to_point! point.dup
  end

  # add vector directly to point (destructive update)
  def add_to_point! point
    vectors.each do |v|
      point.add! v
    end
    point
  end

  def sub_from_point point
    reverse_directions.add_to_point point    
  end

  def sub_from_point! point
    reverse_directions.add_to_point! point
  end

  def reverse_directions
    vectors.each do |v|
      v.reverse!
    end    
    self
  end

  def to_s
    inject([]) do |res, v|
      res << v.to_s
      res
    end.join(' ; ')
  end
  
  protected
  
  def check_valid!
    raise "Only works for an Array of GeoVector" if !valid?
  end
  
  def valid?
    kind_of?(Array) && only_kinds_of?(GeoVector)
  end
end  