class GeoVector 
  module Addition    
    def apply_to obj
    end

    def << obj
      apply_to arg        
    end

    def + vector
      apply_to arg        
    end

    def - vector
      apply_to vector.reverse
    end
  end
end