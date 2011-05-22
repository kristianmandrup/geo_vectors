require 'spec_helper'

describe BearingVector do
  describe '#initialize' do
    it 'should create Bearing Vector from distance and degrees' do
      v = BearingVector.new 2.km, 32
      v.distance.should == 2.km
      v.bearing.should == 32      
    end      

    it 'should create Bearing Vector from degrees and distance' do
      v = BearingVector.new 32, 2.km
      v.distance.should == 2.km
      v.bearing.should == 32      
    end      

    it 'should create Bearing Vector from 2 numbers, assuming first arg is distance in :kms' do
      v = BearingVector.new 2, 32
      v.distance.should == 2.km
      v.bearing.should == 32      
    end      

    it 'should NOT create Bearing Vector from 1 argument' do
      lambda {BearingVector.new 2}.should raise_error
    end      
  end
      
  context 'Simple Bearing Vector 2 km at 32 degrees' do
    let(:vector) { BearingVector.new 32, 2.km }
    
    it 'should create a GeoVector: x=1, y=1' do
      vector.should be_a(BearingVector)
    end
  end
end