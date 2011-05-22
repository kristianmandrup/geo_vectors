require 'geo_vectors/util/geo_units'
require 'active_support/inflector'

class GeoDistance
  include NumericCheckExt
  include GeoUnits 
  include Comparable
  
  attr_accessor :unit, :number
  
  def initialize number, unit = :kms
    check_unit! unit
    check_numeric! number 

    @unit = unit
    @number = number
  end

  def to_s
    "distance: #{number} #{unit}"
  end

  def * factor  
    dist = self.dup
    dist.number *= factor
    dist
  end

  def / factor  
    dist = self.dup
    dist.number /= factor
    dist
  end

  # compare 2 distances
  def <=> dist
    dist = extract_distance(dist).as(unit)
    if number < dist.number
      -1
    elsif number > dist.number
      1
    else
      0
    end
  end

  def convert_to_meters
    (unit == :radians) ? radians_to(:meters) : number / meters_map[unit]
  end

  # convert to unit (see GeoMagic)
  def as unit
    check_unit! unit
    dist = self.dup
    dist.number = convert_to_meters * meters_map[unit]
    dist.unit = unit
    dist    
  end

  # from GeoUnits    
  GeoUnits.valid_units.map(&:to_s).each do |unit|
    one_unit = unit.singularize
    class_eval %{
      def #{one_unit}
        as(:#{unit}).number
      end          

      def as_#{unit}
        as(:#{unit})
      end          

      alias_method :to_#{unit}, :#{one_unit}
      alias_method :in_#{unit}, :#{one_unit}
      alias_method :#{unit.pluralize}, :#{one_unit}
    }
  end   


  def radians_to unit
    check_unit! unit
    earth_radius[unit] * number
  end

  protected

  include GeoUnits::UnitMaps

  # converts a number into a distance of same unit  
  def extract_distance dist
    is_numeric?(dist) ? dist.send(unit) : dist  
  end

  # used to extend Fixnum and Float
  module Unit
    extend GeoUnits
    extend GeoUnits::UnitMaps
    
    # from GeoUnits    
    valid_units.map(&:to_s).each do |unit|
      one_unit = unit.singularize
      class_eval %{
        def #{one_unit}
          GeoDistance.new self, :#{unit}
        end          
        alias_method :to_#{unit}, :#{one_unit}
        alias_method :in_#{unit}, :#{one_unit}
        alias_method :as_#{unit}, :#{one_unit}
        alias_method :#{unit.pluralize}, :#{one_unit}
      }
    end   
    
    def [] key
      raise ArgumentError, "Invalid unit key #{key}" if !respond_to? key
      earth_radius[key] * self
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