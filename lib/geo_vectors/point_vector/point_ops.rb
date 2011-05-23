class PointVector < GeoVector
  module PointOps
    # return new point from adding vector to point
    def add_to_point point
      add_to_point! point.dup
    end

    # add vector directly to point (destructive update)
    def add_to_point! point
      point.lat = lat + point.lat 
      point.lng = lng + point.lng
      point
    end

    def sub_from_point point
      reverse.add_to_point point    
    end

    def sub_from_point! point
      reverse.add_to_point! point
    end
  end
end