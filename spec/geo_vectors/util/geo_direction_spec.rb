require 'spec_helper'

describe GeoDirection do
  describe 'module methods' do
    describe '#valid_directions?' do
      it 'should list valid directions' do
        GeoUnits.valid_directions.should include(:kms, :meters)
      end
      
      it 'should be that :km is a valid direction' do
        GeoUnits.valid_direction? :km
      end

      describe '#dir_to_bearing' do
        it 'should convert North to 90 deg' do
          GeoUnits.dir_to_bearing(:N).should == 90
        end

        it 'should raise error on invalid direction' do
          lambda { GeoUnits.dir_to_bearing(:Sud) }.should raise_error
        end
      end

      describe '#bearing_to_dir' do
        it 'should convert 90 deg to North' do
          GeoUnits.bearing_to_dir(90).should == :N
        end
        
        it 'should raise error bearing that has no direction symbol' do
          lambda { GeoUnits.bearing_to_dir(100) }.should raise_error
        end
      end

      describe '#get_valid_dir' do
        it 'should convert :north to :N' do
          GeoUnits.get_valid_dir(:north).should == :N
        end
      end
    end
  end
end