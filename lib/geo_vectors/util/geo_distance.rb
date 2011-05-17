require 'geo_vectors/util/geo_units'

class GeoDistance   
  module Unit
    GeoUnits.valid_units.each do |unit|
      class_eval %{
        def #{unit.singularize}
          GeoDistance.new self, :#{unit}
        end          
        alias_method :to_#{unit}, #{unit}
        alias_method :#{unit.pluralize}, #{unit}
      }
    end
  end

  module Extract
    def extract_distance dist
      case dist
      when Fixnum, Float
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