require 'spec_helper'
require 'geo_vectors'

describe GeoDistance do
  describe 'Unit' do
    it 'should NOT convert 5.blips into a GeoDistance obj' do
      lambda {5.blips}.should raise_error
    end

    it 'should convert 5.km into a GeoDistance obj' do
      dist = 5.km
      dist.should be_a GeoDistance
      dist.unit.should == :kms
      dist.number.should == 5
    end
  end

  context 'Distance' do    
    describe '#* multiply operator' do
      it "should multiply and return a new distance" do
        dist = 5.km
        new_dist = dist * 2
        new_dist.number.should == 5 * 2
      end
    end

    describe '#/ divide operator' do
      it "should divide and return a new distance" do
        dist = 10.km
        new_dist = dist / 2
        new_dist.number.should == 5
      end
    end

    describe '#> gte operator' do    
      it "should be that twice the distance is greater than original distance" do
        20.km.should > 10.km
      end

      it "should be that half the distance is smaller than original distance" do
        5.km.should < 10.km
      end

      it "should be that 1000 m is same distance as 1 km" do
        (1000.meters == 1.km).should be_true
      end
    end
    
    describe '#in_meters' do
      it "should be that 5.km in meters is 5000" do
        5.km.in_meters.should == 5000
      end
    end

    describe '#random' do
      it "should be that a 5.km random distance is between 0 - 5000 meters" do
        rand_dist = 5.km.random
        rand_dist.in_meters.should be_between(0, 5000)
      end
    end

    describe '#in_kms' do
      it "should be that 5000 meters in kms is 5" do
        dist = 5000.meters
        dist.should be_a GeoDistance
        dist.in_kms.should == 5
      end
    end      
  end
end