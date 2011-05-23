class GeoVector
  module Parser
    module ClassMethods
      def create_vector *args
        first_arg = args[0]             
        first_arg.any_kind_of?(GeoVector, GeoVectors) ? first_arg : parse_vector(*args)
      end

      def parse_vector *args
        res = [:point, :bearing, :direction, :multiple].map {|type| send parser(type), *args }.compact.first
        raise ArgumentError, "No GeoVector could be created from arguments: #{args}" if !res
        res
      end

      def parser type
        "parse_#{type}_vector"
      end

      def parse_multiple_vector *args 
        begin
          GeoVectors.new *args
        rescue
          nil
        end
      end

      def parse_point_vector *args 
        begin
          PointVector.new *args
        rescue
          nil
        end
      end

      def parse_bearing_vector *args 
        begin
          BearingVector.new *args
        rescue
          nil
        end
      end
      
      def parse_direction_vector *args 
        begin
          DirectionVector.new *args
        rescue
          nil
        end
      end      
    end
    
    extend ClassMethods
  end
end