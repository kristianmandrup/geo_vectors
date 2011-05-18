require 'spec_helper'

class GeoDirectionClass
  extend GeoDirection
end

class Fixnum
  def kms
    self * 1000
  end
end

describe GeoDirection do
  describe 'module methods' do
    before do
      @gd = GeoDirectionClass
    end
    
    describe '#valid_directions?' do
      it 'should list valid directions' do
        @gd.valid_directions.should include(:N, :south)
      end
      
      it 'should be that :km is a valid direction' do
        @gd.valid_direction? :km
      end

      describe '#dir_to_bearing' do
        it 'should convert North to 90 deg' do
          @gd.dir_to_bearing(:N).should == 90
        end

        it 'should raise error on invalid direction' do
          lambda { @gd.dir_to_bearing(:Sud) }.should raise_error
        end
      end

      describe '#bearing_to_dir' do
        it 'should convert 90 deg to North' do
          @gd.bearing_to_dir(90).should == :N
        end
        
        it 'should raise error bearing that has no direction symbol' do
          lambda { @gd.bearing_to_dir(100) }.should raise_error
        end
      end

      describe '#to_bearing_vector' do
        it 'should direction and distance to a bearing vector' do
          bvec = @gd.to_bearing_vector(:N, 2.kms)
          puts bvec.inspect
          bvec.should be_a(BearingVector)
          bvec.bearing.should == 90
          # bvec.distance.unit == :km
          # bvec.distance.in_meters.should == 2000          
        end
      end

      describe '#to_bearing_vector' do
        it 'should direction and distance to a bearing vector' do
          pvec = @gd.to_point_vector(:E, 2.kms)
          pvec.should be_a(PointVector)
          pvec.lng.should == 2.kms #.to_degrees # x
          pvec.lat.should == 0 # y
        end
      end

      describe '#get_valid_dir' do
        it 'should convert :north to :N' do
          @gd.get_valid_direction(:north).should == :N
        end
      end
    end
  end
end