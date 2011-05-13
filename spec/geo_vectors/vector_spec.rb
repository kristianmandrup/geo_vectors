require 'spec_helper'

describe GeoVector do
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


#   context 'an almost 1 radian vector' do
#     before :each do
#       @a      = [45.1, 11].to_point
#       @b      = [46, 11.4].to_point
#       @vector = GeoVector.new @a, @b
#     end
# 
#     describe 'Class' do
#       it "is a GeoMagic::Vector" do
#         @vector.should be_a(GeoVector)
#       end
#     end
# 
#     describe 'class methods' do
#       describe '#create_at' do
#         it "should create a vector from a point and another vector" do
#           v2 = GeoMagic::Vector.create_at @a, @vector
#           v2.should be_a(GeoMagic::Vector)
#         end
#       end
#     end
# 
#     describe '#distance' do
#       it "is has a distance" do
#         @vector.distance.should be_a(GeoMagic::Distance)
#         @vector.distance.in_meters.should > 500
#       end
#     end
# 
#     describe '#lat_factor' do
#       it "is has a lat_factor of 2" do
#         @vector.lat_factor.should >= 2
#       end
#     end
#     
#     describe '#length' do
#       describe ':latitude' do
#         it "is has a latitude length of ..." do
#           @vector.length(:latitude).in_kms.should >= 0.5
#         end
#       end
# 
#       describe ':longitude' do
#         it "is has a longitude length of ..." do
#           @vector.length(:longitude).in_kms.should >= 0.5
#         end
#       end
#     end    
# 
#     describe '#vector_distance' do
#       it "is has a vector_distance" do
#         @vector.vector_distance.should be_a(GeoMagic::DistanceVector)
#       end
# 
#       it "is has a latitude distance < #{RAD_KM_LAT45}" do
#         lat_dist = @vector.vector_distance.lat_distance.km
#         lat_dist.should < RAD_KM_LAT45
#       end
# 
#       it "is has a longitude distance < 15" do
#         long_dist = @vector.vector_distance.long_distance.km
#         # puts long_dist
#         long_dist.should < 15
#       end
#     end   
#   end
# end        
