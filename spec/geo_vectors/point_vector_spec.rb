require 'spec_helper'

# Same as GeoVector !!!

describe PointVector do
  describe '#initialize' do
    it 'should initialize from an Array' do
      vec = [1, 2].vector
      vec.should be_a(PointVector)
    end
  end

  context 'Simple vector at (1, 2) - x,y arg' do
    let(:vector) { GeoVector.new 1, 2 }
    
    it 'should create a GeoVector: x=1, y=1' do
      vector.should be_a(GeoVector)
      vector.x.should == 1
      vector.y.should == 2
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
    let(:vector) { GeoVector.new [1, 2] }

    it 'should create a vector: x=1, y=2' do
      vector.x.should == 1
      vector.y.should == 2
    end
  end

  context 'Vectors from points: p1 = (1,2) ; p2 = (4,6) ' do
    before do
      @p1 = GeoPoint.new 1,2
      @p1 = GeoPoint.new 4,6      
    end

    it 'should create a vector between the points p1 and p2' do
      @vec = GeoVector.new @p1, @p2
      @vec.x.should == 3
      @vec.y.should == 4      
    end
  end

  context 'Simple vector at (1, 2) and a Direction' do
    before do
      @p1 = GeoPoint.new 1,2
      @east_4 = GeoDirection.new 4, :east
    end

    it 'should create a vector between a point and a new point generated from applying the direction to the point' do
      @vec = GeoVector.new @p1, @east_4
      @vec.x.should == 1
      @vec.y.should == 6      
    end
  end

  context 'Simple vector at (1, 2) - GeoPoint arg' do
    let(:vector) { GeoVector.new [1, 2].to_point }

    it 'should create a vector: x=1, y=2' do
      vector.x.should == 1
      vector.y.should == 2
    end

    describe '#distance' do  
      it 'should have a distance between 1 and 2' do
        vector.x.should == 1
        vector.y.should == 2
        vector.distance.should be_between(1,2)
      end
    end

    describe '#point=' do
      before do
        @vec = GeoVector.new [1, 2].to_point
      end
      
      it 'should have a distance between 1 and 2' do        
        @vec.x.should == 1
        @vec.point = 2,3
        @vec.x.should == 2      
        @vec.y.should == 3
      end
      
      it 'should return a new distance between 3 and 5' do
        @vec.distance.should be_between(3,5)
      end
    end
  end  
end