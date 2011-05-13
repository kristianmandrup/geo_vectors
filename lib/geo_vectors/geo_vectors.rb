# Operations that apply on a collection of GeoVector
module GeoVectors
  include GeoVector

  def sum
    check_valid!
    map(:+)
  end
  
  def random
    check_valid!    
    [rand(self.size)]
  end

  protected
  
  def check_valid!
    raise "Only works for an Array of GeoVector" if !valid?
  end
  
  def valid?
    if !self.kind_of?(Array) && self.only_kinds_of?(GeoVector)
  end
end  