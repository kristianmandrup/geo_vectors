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
      describe '#apply_to' do
        it 'should add vector to a point' do
          old_lat = @p.lat
          @v.apply_to(@p)
          @p.lat.should > old_lat
        end
      end

      describe '#add' do
        it 'should add vector to a point' do
          p2 = @p.add(v)
          p2.lat.should > @p.lat
        end
      end

      describe '#+' do
        it 'should add vector to a point' do
          old_lat = @p.lat
          p2 = @p + v
          p2.lat.should > @p.lat
        end
      end
    end

    describe 'Subtraction' do
      describe '#sub' do
        it 'should subtract vector from point' do
          p2 = @p.sub(v)
          p2.lat.should > @p.lat
        end
      end

      describe '#-' do
        it 'should subtract vector from point' do
          old_lat = @p.lat
          p2 = @p - v
          p2.lat.should < @p.lat
        end
      end
    end
  end
 
  context 'an Array of two GeoVectors v1, v2' do
    before do
      @v1 = [1, 2].vector
      @v2 = [30, 4.km].vector
      @vectors = v1 + v2

      @p = [3, 4].geo_point
    end

    describe 'GeoVectors' do
      describe 'adding vectors to a point' do
        it 'should add each vector in succession' do
          old_lat = @p.lat
          old_lng = @p.lng
          p2 =  @p + @vectors
          p21 = @p + @v1

          # adding both vectors should create bigger lat than adding first vector only
          p2.lat.should > p21.lat 

          # adding both vectors should create bigger lat,lng than original point
          p2.lat.should > old_lat
          p2.lng.should > old_lng
        end
      end
    end
  end
end
    
