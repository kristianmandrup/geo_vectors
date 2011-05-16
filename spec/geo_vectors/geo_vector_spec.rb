require 'spec_helper'

# h3. Addition
# 
# Vectors can be added to form a new Vector, using the simple formula vec = v1 + v2 = (v1.x + v2.y, v1.x + v2.y)
# 
# h3. Vector on Vector addition
# 
# If both vectors are point vectors, the result is simply a new point vector
# 
# <pre>
#   v1 = [1, 3].vector
#   v2 = [-2, 2].vector
#   vec = v1 + v2
#   vec.unit.should == :degrees
#   vec.lat.should == -1
#   vec.lng.should == 5
# 
#   # alternative addition operators
#   vec = v1 << v2  
# </pre>  
# 
# h3. Vector subtraction
# 
# <pre>
#   v1 = [1, 3].vector
#   v2 = [2, 1].vector
#   vec = v1 - v2 # here v2 inversed (scaled by -1) and then added 
#   vec.lat.should == -1
#   vec.lng.should == 2
# </pre>
# 
# h3. Vector scaling
# 
# <pre>
#   v1 = [1, 3].vector
#   vec = v1 * 2
#   vec.lat.should == 2
#   vec.lng.should == 6
# </pre>

describe GeoVector do
  describe '#initialize' do
    it 'should init from an Array' do
      vec = [11.1, 2].geo_vector
      vec.should be_a(GeoVector)
      vec.lat.should == 11.1
      vec.lng.should == 2      
    end

    it 'should init from a GeoPoint' do
      vec = "11.1, 2".geo_point.geo_vector
      vec.should be_a(GeoVector)
      vec.lat.should == 11.1
      vec.lng.should == 2
    end

    it 'should init from a Hash' do
      vec = {:lat => 11.1, :lon => 2}.geo_vector
      vec.should be_a(GeoVector)
      vec.lat.should == 11.1
      vec.lng.should == 2
    end

    it 'should init from a String' do
      vec = "11.1, 2".geo_vector
      vec.should be_a(GeoVector)
      vec.lat.should == 11.1
      vec.lng.should == 2
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
