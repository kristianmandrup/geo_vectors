require 'active_support/inflector'

class GeoDistance
  # used to extend Fixnum and Float
  module Unit
    extend GeoUnits
    extend GeoUnits::UnitMaps
  
    # from GeoUnits    
    valid_units.map(&:to_s).each do |unit|
      one  = unit.singularize
      many = unit.pluralize
      class_eval %{
        def #{one}
          GeoDistance.new self, :#{unit}
        end          
        alias_method :to_#{unit}, :#{one}
        alias_method :in_#{unit}, :#{one}
        alias_method :as_#{unit}, :#{one}
        alias_method :#{many},    :#{one}
      }
    end   
  
    def [] key
      raise ArgumentError, "Invalid unit key #{key}" if !respond_to? key
      earth_radius[key] * self
    end    
  end   
end