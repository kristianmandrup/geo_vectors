module GeoDirection
  def valid_directions
    [:north, :south, :east, :west, :NW, :NE, :SW, :SE]
  end
  
  def valid_direction? dir
    valid_directions.include? dir
  end
end