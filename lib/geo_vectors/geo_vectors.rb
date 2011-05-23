# Operations that apply on a collection of GeoVector
class GeoVectors < Array
  include Enumerable
  # include GeoVector
  attr_reader :vectors

  def initialize *vectors
    vectors = vectors.flatten
    raise ArgumentError, "GeoVectors can only contain GeoVector instances" if !vectors.only_kinds_of? GeoVector
    @vectors = vectors
  end

  def each
    @vectors.each { |v| yield v }
  end

  def add_to_point point
    vectors.each do |v|
      point += v
    end
  end
  
  protected
  
  def check_valid!
    raise "Only works for an Array of GeoVector" if !valid?
  end
  
  def valid?
    kind_of?(Array) && only_kinds_of?(GeoVector)
  end
end  