require 'spec_helper'

describe BearingVector do
  describe '#initialize' do
    it 'should create Bearing Vector from distance and degrees' do
      v = BearingVector.new 2.km, 32
      v.should be_a BearingVector
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

  describe '#to_s' do
    it 'should print distance and bearing' do
      BearingVector.new(2, 32).to_s.should match /distance: 2 kms, bearing: 32 degrees/      
    end    
  end      
end