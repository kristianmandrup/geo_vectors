require 'spec_helper'

describe PointVector do
  describe '#initialize' do
    describe 'pure call' do    
      it 'should init from an Array' do
        vec = PointVector.new [11.1, 2]
        vec.should be_a(PointVector)
        vec.lat.should == 11.1
        vec.lng.should == 2      
      end

      it 'should init from a Hash' do
        vec = PointVector.new :lat => 11.1, :lon => 2
        vec.should be_a(PointVector)
        vec.lat.should == 11.1
        vec.lng.should == 2
      end

      it 'should init from a String' do
        vec = PointVector.new "11.1, 2"
        vec.should be_a(PointVector)
        vec.lat.should == 11.1
        vec.lng.should == 2
      end

      describe 'two args' do
        it 'should init from two Strings' do
          vec = PointVector.new "11.1", "2"
          vec.should be_a(PointVector)
          vec.lat.should == 11.1
          vec.lng.should == 2
        end

        it 'should init from two numbers' do
          vec = PointVector.new 11.1, 2
          vec.should be_a(PointVector)
          vec.lat.should == 11.1
          vec.lng.should == 2
        end

        it 'should init from a number and a String' do
          vec = PointVector.new 11.1, "2"
          vec.should be_a(PointVector)
          vec.lat.should == 11.1
          vec.lng.should == 2
        end
      end
    end
    
    describe 'factory methods on other class' do
      it 'should init from an Array' do
        vec = [11.1, 2].geo_vector
        vec.should be_a(PointVector)
        vec.lat.should == 11.1
        vec.lng.should == 2      
      end

      it 'should init from a GeoPoint' do
        vec = "11.1, 2".geo_point.geo_vector
        vec.should be_a(PointVector)
        vec.lat.should == 11.1
        vec.lng.should == 2
      end

      it 'should init from a Hash' do
        vec = {:lat => 11.1, :lon => 2}.geo_vector
        vec.should be_a(PointVector)
        vec.lat.should == 11.1
        vec.lng.should == 2
      end

      it 'should init from a String' do
        vec = "11.1, 2".geo_vector
        vec.should be_a(PointVector)
        vec.lat.should == 11.1
        vec.lng.should == 2
      end
    end
  end
end
      
