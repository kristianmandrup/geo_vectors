require 'spec_helper'

describe GeoVectors do
  context 'an empty Array' do
  end

  context 'an Array of one GeoVector v1' do
    before do
      @v1 = [1, 2].vector
      @v2 = [30, 4.km].vector
      @v = v1 + v2

      @p = [3, 4].geo_point
    end

    describe '#vectors' do
      @v.vectors.first.should == @v1
      @v.vectors.last.should == @v2
    end
    
    describe 'Addition' do
      @v.apply_to(@p)
      @p.add(v)
      p2 = @p + @v
    end
  end

  context 'an Array of two GeoVectors v1, v2' do
  end

  context 'an Array of three GeoVectors v1, v2, v3' do
  end
end
    
