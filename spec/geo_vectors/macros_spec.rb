require 'spec_helper'
require 'geo_vectors/macros'

describe 'Macros' do
  describe 'Array macros' do 
    describe '#vector' do
      it 'should create Point Vector from lat and lng' do
        v = [2, 32].vector
        v.should be_a PointVector
        v.lat.should == 2
        v.lng.should == 32      
      end
    end

    describe '#vector' do
      it 'should create Direction Vector from distance and direction' do
        v = [2.km, :north].vector
        v.should be_a DirectionVector
        v.distance.should == 2.km
        v.direction.should == :N      
      end

      it 'should create Bearing Vector from distance and degrees' do
        v = [2.km, 32].vector
        v.should be_a BearingVector
        v.distance.should == 2.km
        v.bearing.should == 32      
      end
    end
  end
  
  describe 'Hash macros' do 
    describe '#point_vector' do
      it 'should create Point Vector from lat and lng' do
        v = {:lat => 2, :lng => 32}.point_vector
        v.should be_a PointVector
        v.lat.should == 2
        v.lng.should == 32      
      end
    end
  end

  describe 'String macros' do 
    describe '#point_vector' do
      it 'should create Point Vector from lat and lng in String' do
        v = "2, 32".point_vector
        v.should be_a PointVector
        v.lat.should == 2
        v.lng.should == 32      
      end
    end
  end

  describe 'GeoPoint macros' do 
    describe '#point_vector' do
      it 'should create Point Vector from a GeoPoint' do
        v = "2, 32".geo_point.point_vector
        v.should be_a PointVector
        v.lat.should == 2
        v.lng.should == 32      
      end
    end
  end    
end