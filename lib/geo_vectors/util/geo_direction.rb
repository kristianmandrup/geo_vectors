module GeoDirection
  def valid_directions
    [:north, :south, :east, :west, :N, :S, :E, :W, :NW, :NE, :SW, :SE]
  end

  def directions
    [:N, :S, :E, :W, :NW, :NE, :SW, :SE]
  end
  
  def valid_direction? dir
    valid_directions.include? dir
  end

  def dir_to_bearing dir
    dir = dir_to_bearing_map[dir]
    raise "No bearing for direction #{dir} could be found" if !dir
    dir
  end

  def bearing_to_dir brng
    dir = bearing_to_dir_map[:"_#{brng}"]
    raise "No direction could be for the bearing #{brng}" if !dir
    dir
  end

  def get_valid_direction dir
    return dir_map[dir] if dir_map[dir]
    raise "Not a valid direction: #{dir}" if !directions.include? dir
    dir
  end  

  def to_bearing_vector direction, distance
    BearingVector.new dir_to_bearing(direction), distance
  end

  def to_point_vector direction, distance
    # dist degrees
    dd = distance.to_deg
    
    lat, lng = case direction
    when :N
      [0, -dd]
    when :S
      [0, dd]
    when :W
      [-dd, 0]
    when :E
      [dd, 0]
    when :NW
      [dd, b]
    when :SW
      [dd, -dd]
    when :NE
      [-dd, dd]
    when :SE
      [-dd, -dd]
    end
    [lat, lng].vector
  end

  protected

  def dir_map 
    {:east => :E, :north => :N, :west => :W, :south => :S}
  end
  
  def bearing_to_dir_map
    {
      :_0   => :N,    # East
      :_45  => :NE,   # North East
      :_90  => :N,    # North
      :_135 => :NW,   # North West
      :_180 => :W,    # West (2*90)
      :_225 => :SW,   # South West
      :_270 => :S,    # South (3*90)
      :_315 => :SE    # South East
    }
  end  
  
  def dir_to_bearing_map
    {
      :E  => 0,     # East
      :NE => 45,    # North East
      :N  => 90,    # North
      :NW => 135,   # North West
      :W  => 180,   # West (2*90)
      :SW => 225,   # South West
      :S  => 270,   # South (3*90)
      :SE => 315    # South East
    }
  end  
end