class GeoVector  
  module Math
    # Scale Vector v1, larger or smaller
    module Scale
      def scale scalar
        x = x * scalar
        y = y * scalar
      end      

      def * scalar
        scale scalar
      end 
      alias_method :enhance, :*
      alias_method :grow_by, :*

      def / scalar
        scale (1.0 / scalar)
      end
      alias_method :reduce, :/
    end
  end
end