require 'spec_helper'

# mock of GeoPoint
class GeoP
  include class GeoVector::Math::PointAdd

  attr_accessor :lat, :lng 
end

describe GeoVector do
  describe 'PointAdd module' do
    # Should mock the GeoPoint 

    before do
      @point = GeoPoint.new 0,1
    end
    
    context 'Simple vector at (1, 2) - x,y arg' do
      let(:vector) { GeoVector.new 1, 2 }

      describe '#apply!' do
        it 'should create a vector: latitude=1, longitude=1' do
          @point.apply!(vector)
          p2.lat.should == 1
          p2.lng.should == 2
        end
      end

      describe '#+ (add)' do
        it 'should add the vector and create a new point from result' do
          p2 = @point + vector
          p2.lat.should == 1
          p2.lng.should == 2
        end
      end

      describe '#<< (push)' do
        it 'should push the vector onto the point creating a new point' do
          p2 = @point << vector
          p2.lat.should == 1
          p2.lng.should == 2
        end
      end
    end
  end
end
