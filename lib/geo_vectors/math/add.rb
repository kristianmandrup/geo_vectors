class GeoVector  
  module Math
    # Add Vectors v1 + v2
    module Add    
      def apply_to arg
        def apply_to arg
          raise ArgumentError, "Argument must be a GeoMagic::Point or a GeoMagic::PointVector" if !arg.any_kind_of?(GeoMagic::Vector, GeoMagic::PointVector)
          case arg
          when GeoMagic::Point
          when GeoMagic::PointVector
          end
        end    
      end

      def << arg
        apply_to arg        
      end

      def + arg
        apply_to arg        
      end
    end
  end
end