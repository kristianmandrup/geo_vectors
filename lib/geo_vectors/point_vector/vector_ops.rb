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
      self.dup.add! *args 
    end
    alias_method :<<, :add
    alias_method :+,  :add

    def add! *args
      vector = GeoVector::Parser.create_vector *args
      case vector
      when PointVector
        v2 = add_to_point vector
        self.point = v2.to_arr
        self      
      else
        GeoVectors.new self, vector
      end
    end

    def sub *args
      self.dup.sub! *args
    end

    def sub! *args
      vector = GeoVector::Parser.create_vector *args
      add! vector.reverse
    end
  end
end