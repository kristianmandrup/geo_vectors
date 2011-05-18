module GeoVector
  module Add
    def add vector
      raise '#add method must be implemented by including class'
    end

    alias_method :<<, :add
    alias_method :+,  :add

    def - vector
      add vector.reverse
    end
  end
end
