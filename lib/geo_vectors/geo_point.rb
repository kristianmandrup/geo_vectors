class GeoPoint  
  include GeoCalc
  
  def + *args
    vec = create_vector *args
    vec.add_to_point self
  end
  alias_method :add, :+
  alias_method :<<, :+
  
  def add! *args
    vec = create_vector *args
    vec.add_to_point! self if vec
  end  

  def vector
    to_lat_lng.vector
  end
  
  protected
  
  def create_vector *args
    return args[0] if args[0].kind_of?(GeoVector) && args.size == 1
    GeoPoint.new(*args).vector
  end
end