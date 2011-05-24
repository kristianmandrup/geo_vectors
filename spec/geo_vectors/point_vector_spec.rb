require 'spec_helper'

describe PointVector do
  describe '#initialize' do    
    it 'should set origin at 0,0' do
      origin = PointVector.origin
      origin.lat.should == 0       
      origin.lng.should == 0
    end
  end

  context 'Simple vector at (1, 2) - x,y arg' do
    let(:vector) { PointVector.new 1, 2 }
    
    it 'should create a PointVector: x=1, y=1' do
      vector.should be_a PointVector
      vector.y.should == 1          
      vector.x.should == 2      
    end

    it 'should create a vector: lat=1, lng=1' do
      vector.lat.should == 1
      vector.lng.should == 2
    end

    it 'should create a vector: latitude=1, longitude=1' do
      vector.latitude.should == 1
      vector.longitude.should == 2
    end
  end

  context 'Simple vector at (1, 2) - Array arg' do
    let(:vector) { PointVector.new [1, 2] }

    it 'should create a vector: x=1, y=2' do
      vector.y.should == 1
      vector.x.should == 2
    end
  end

  context 'Vectors from points: p1 = (1,2) ; p2 = (4,6) ' do
    before do
      @p1 = GeoPoint.new 1,2
      @p2 = GeoPoint.new 4,6      
    end

    it 'should create a vector between the points p1 and p2' do
      @vec = PointVector.new @p1, @p2
      @vec.y.should == 3
      @vec.x.should == 4      
    end
  end

  pending 'TODO' do
    context 'Simple vector at (1, 2) and a direction vector' do
      before do
        @p1     = GeoPoint.new 1,2
        @east_4 = DirectionVector.new 4.km, :east
      end
  
      it 'should create a vector between a point and a new point generated from applying the direction to the point' do
        @vec = PointVector.new @p1, @east_4
        @vec.x.should == 1
        @vec.y.should == 6      
      end
    end
  end

  context 'Simple vector at (1, 2) - GeoPoint arg' do
    let(:vector) { PointVector.new [1, 2] }

    describe '#length' do  
      it 'should have a distance between 240 - 250 km' do
        kms = vector.length
        kms.should be_between(240, 250)
      end
    end
  
    describe '#distance' do  
      it 'should have a distance between 240 - 250 km' do
        dist = vector.distance
        dist.should be_a GeoDistance
        dist.in_meters.should be_between(240000, 250000)
      end
    end
  
    describe '#point=' do
      before do
        @vec = PointVector.new [1, 2]
      end
      
      it 'should set a new vector point of 2,3' do        
        @vec.y.should == 1
        @vec.x.should == 2
        @vec.point = 2, 3
        @vec.y.should == 2      
        @vec.x.should == 3
      end
      
      it 'should return a new distance between 240 - 250' do
        kms = @vec.distance.in_kms
        kms.should be_between(240, 250)
      end
    end
  end  
end