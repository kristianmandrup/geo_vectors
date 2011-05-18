class BearingVector
  module Add
    # return new point from adding vector to point
    def add_to_point point
      destination_point bearing, distance.in_kms
    end

    # add vector directly to point (destructive update)
    def add_to_point! point
      dest = destination_point bearing, distance.in_kms
      point.lat = dest.lat
      point.lng = dest.lng
      point
    end
  end
end