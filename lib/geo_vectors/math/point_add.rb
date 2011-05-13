class GeoVector  
  module Math
    # Add Vector v1 to a GeoPoint
    # This module should be included in the GeoPoint class !!!
    module PointAdd    

      def apply! vector
        raise ArgumentError, "Argument must be a GeoVector" if !vector.kind_of?(GeoVector)
        @lat = lat + vector.lat
        @lng = lng + vector.lng
      end    

      def + vector, mode = :relative
        calc_point vector, mode
      end
      alias_method :<<, :+
      
      protected
      
      def earth_radius_radians
        2 * Math::PI
      end

      def bounding_box(point, radius, options = {})
        lat,lon = extract_coordinates(point)
        radius  = radius.to_f
        units   = options[:units] || :mi
        [
          lat - (radius / latitude_degree_distance(units)),
          lon - (radius / longitude_degree_distance(lat, units)),
          lat + (radius / latitude_degree_distance(units)),
          lon + (radius / longitude_degree_distance(lat, units))
        ]
      end

      def calc_point vector, mode
        vector = relative_vector(vector) if mode == :relative
        GeoPoint.new lat + vector.lat, lng + vector.lng        
      end 
      
      def relative_vector vector
        delta_lng = vector.lng / longitude_radian_distance(lat)
        delta_lat = vector.lat / latitude_radian_distance
        Vector.new delta_lat, delta_lng
      end

      def degrees_to_radians degrees
        degrees / 57.29578
      end

      def delta_lat degrees, distance
        rad = degrees_to_radians(degrees)
        Math.sin(rad) * distance
      end

      def delta_lng degrees, distance
        rad = degrees_to_radians(degrees)
        Math.cos(rad) * distance
      end

      def latitude_radian_distance
        0.017453292519943295
      end

      def longitude_radian_distance(latitude)
        latitude_radian_distance * Math.cos(latitude)
      end

      def distance_to_radians(distance, units = :mi)
        distance.to_f / earth_radius(units)
      end

      def radians_to_distance(radians, units = :mi)
        radians * earth_radius(units)
      end
      
      ##
      # Distance spanned by one degree of latitude in the given units.
      #
      def latitude_degree_distance(units = :mi)
        2 * Math::PI * earth_radius(units) / 360
      end

      ##
      # Convert kilometers to miles.
      #
      def to_miles(km)
        km * km_in_mi
      end

      ##
      # Radius of the Earth in the given units (:mi or :km). Default is :mi.
      #
      def earth_radius(units = :mi)
        units == :km ? EARTH_RADIUS : to_miles(EARTH_RADIUS)
      end

      ##
      # Distance spanned by one degree of longitude at the given latitude.
      # This ranges from around 69 miles at the equator to zero at the poles.
      #
      def longitude_degree_distance(latitude, units = :mi)
        latitude_degree_distance(units) * Math.cos(to_radians(latitude))
      end      
    end
  end
end