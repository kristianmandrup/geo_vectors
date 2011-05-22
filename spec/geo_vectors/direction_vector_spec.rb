require 'spec_helper'

describe DirectionVector do
  describe '#initialize' do
    it 'should create Direction Vector from distance and direction' do
      v = DirectionVector.new 2.km, :north
      v.distance.should == 2.km
      v.direction.should == :N
    end      

    it 'should create Direction Vector from degrees and distance' do
      v = DirectionVector.new :north, 2.km
      v.distance.should == 2.km
      v.direction.should == :N
    end      

    it 'should create Direction Vector from number and direction, assuming number is distance in :kms' do
      v = DirectionVector.new 2, :north
      v.distance.should == 2.km
      v.direction.should == :N
    end      

    it 'should NOT create Direction Vector from 1 argument' do
      lambda {DirectionVector.new 1}.should raise_error
    end      
  end
end