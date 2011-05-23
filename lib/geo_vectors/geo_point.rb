class GeoPoint  
  include GeoCalc
  
  def + *args
    self.dup.add! *args
  end
  alias_method :add, :+
  alias_method :<<, :+
  
  def add! *args
    vec = GeoVector::Parser.create_vector *args
    vec.add_to_point! self
  end  

  def - *args
    self.dup.sub! *args
  end
  alias_method :sub, :-
  
  def sub! *args
    vec = GeoVector::Parser.create_vector *args
    vec.sub_from_point! self
  end  

  def vector
    to_lat_lng.vector
  end

  def geo_point
    self
  end
  
end