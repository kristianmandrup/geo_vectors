class GeoDistance
  module Extract
    def extract_distance dist
      case dist
      when is_numeric? dist
        dist.km
      when GeoDistance
        dist
      else
        raise ArgumentError, "Could not convert #{dist} to a GeoDistance"
      end
    end
  end
  
  include Extract 
end