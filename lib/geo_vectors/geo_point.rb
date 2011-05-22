class GeoPoint  
  include GeoCalc
  
  def + vec
    vec.add_to_point self
  end
  alias_method :add, :+
  alias_method :<<, :+
  
  def add! vec
    vec.add_to_point! self
  end  
end