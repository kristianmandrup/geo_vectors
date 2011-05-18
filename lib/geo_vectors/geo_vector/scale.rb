module GeoVector::Scale
  def scale scalar
    lat = lat * scalar
    lng = lng * scalar
  end      

  def * scalar
    scale scalar
  end 
  alias_method :enhance, :*
  alias_method :grow_by, :*

  def / scalar
    scale (1.0 / scalar)
  end
  alias_method :reduce, :/
end
