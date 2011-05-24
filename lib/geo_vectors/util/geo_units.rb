module GeoUnits
  module Methods
    def valid_units
      [:feet, :meters, :kms, :miles, :radians]
    end

    def valid_unit? unit
      valid_units.include? unit
    end

    # The default unit is assumed to be kms
    # This can be changed
    # Example:
    #   GeoVector.default_unit = :km

    def default_unit
      @default_unit || :kms
    end

    def default_unit= unit
      @default_unit || :kms
    end

    def check_unit! unit
      raise ArgumentError, "Not a valid unit" if !valid_unit? unit
    end   
  end
  
  include Methods
  extend Methods
  
  module UnitMaps

    def earth_radius
      {
        :feet => 20895592, 
        :meters => 6371000,
        :kms => 6371, 
        :miles => 3956
      }
    end

    def meters_map
      {
       :feet => 3.2808,
       :meters => 1,
       :kms => 0.001,
       :miles => 0.00062137,
       :radians => 111170
      }
    end
  end    
end