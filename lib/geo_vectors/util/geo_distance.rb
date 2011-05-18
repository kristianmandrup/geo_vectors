require 'geo_vectors/util/geo_units'
require 'active_support/inflector'

class GeoDistance   
  module Unit
    extend GeoUnits    
    valid_units.map(&:to_s).each do |unit|
      one_unit = unit.singularize
      class_eval %{
        def #{one_unit}
          GeoDistance.new self, :#{unit}
        end          
        alias_method :to_#{unit}, :#{one_unit}
        alias_method :#{unit.pluralize}, :#{one_unit}
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