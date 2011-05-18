class DirectionVector
  module Add
    # return new point from adding vector to point
    def add_to_point point
      vec = to_bearing_vector
      point.destination_point vec.bearing, vec.distance.in_kms
    end

    # add vector directly to point (destructive update)
    def add_to_point! point
      vec = to_bearing_vector
      dest = point.destination_point vec.bearing, vec.distance.in_kms
      point.lat = dest.lat
      point.lng = dest.lng
      point
    end
  end
end