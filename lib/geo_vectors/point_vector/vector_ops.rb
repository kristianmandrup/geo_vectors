class PointVector < GeoVector
  module VectorOps
    def random_vector                             
      lat_max = point.lat.abs
      lng_max = point.lng.abs    
      rand_lat = rand(lat_max * 2) - lat_max
      rand_lng = rand(lng_max * 2) - lng_max
      PointVector.new [rand_lat, rand_lng]
    end

    def add *args
      vector = GeoVector::Parser.create_vector *args
      case vector
      when PointVector
        add_to_point vector
      else
        GeoVectors.new self, vector
      end
    end
    alias_method :<<, :add
    alias_method :+,  :add

    def add! vector
      raise ArgumentException, "The object added must be a GeoVector, was: #{vector}" if !vector.kind_of?(GeoVector)
      case vector
      when PointVector
        v2 = add_to_point vector
        self.point = v2.to_arr
        self      
      else
        GeoVectors.new self, vector
      end
    end

    def sub vector
      raise ArgumentException, "The object subtracted must be a GeoVector, was: #{vector}" if !vector.kind_of?(GeoVector)    
      add vector.reverse
    end

    def sub! vector
      raise ArgumentException, "The object subtracted must be a GeoVector, was: #{vector}" if !vector.kind_of?(GeoVector)    
      add! vector.reverse
    end
  end
end