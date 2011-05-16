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
    dir_to_bearing_map dir
  end

  def bearing_to_dir brng
    dir = bearing_to_dir_map :"_#{brng}"
    return dir if dir
    raise "No direction could be for the bearing #{brng}"
  end

  def get_valid_dir dir
    return dir_map[dir] if dir_map[dir]
    raise "Not a valid direction: #{dir}" if !directions.include? dir
    dir
  end
  
  protected 

  def dir_map 
    {:east => :E, :north => :N, :west => :W, :south => :S}
  end
  
  def bearing_to_dir_map
    {
      :_0   => :N,  # East
      :_45  => :NE  # North East
      :_90  => :N,  # North
      :_135 => :NW  # North West
      :_180 => :W   # West (2*90)
      :_225 => :SW  # South West
      :_270 => :S   # South (3*90)
      :_315 => :SE  # South East
    }
  end  
  
  def dir_to_bearing_map
    {
      :E  => 0,   # East
      :NE => 45   # North East
      :N  => 90,  # North
      :NW => 135  # North West
      :W  => 180  # West (2*90)
      :SW => 225  # South West
      :S  => 270  # South (3*90)
      :SE => 315  # South East
    }
  end  
end