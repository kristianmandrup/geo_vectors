module GeoVector::PointAdd
  def apply! vector
    raise ArgumentError, "Argument must be a GeoVector" if !vector.kind_of?(GeoVector)
    @lat = lat + vector.lat
    @lng = lng + vector.lng
  end    

  def + vector, mode = :relative
    calc_point vector, mode
  end
  alias_method :<<, :+  
end
