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

require 'spec_helper'

describe GeoVector do
  describe 'Vector on Vector Addition' do
    context 'Point vector (4, 2)' do
      describe '#+ operator' do      
        let (:vec) { vec = [4, 2].vector }
        
        it 'should Add one geo vector' do
          v2 = vec + [1,2].vector
          v2.lat.should == 5
          v2.lng.should == 4
        end
      end #+

      describe '#add! operator' do      
        let (:vec) { vec = [4, 2].vector }
        
        it 'should Add one geo vector' do
          vec.add!([1,2].vector)
          vec.lat.should == 5
          vec.lng.should == 4
        end

        describe 'converting args to vector' do
          let (:vec) { vec = [4, 2].vector }
          
          it 'should Add after converting number args to geo vector' do
            vec.add!(1,2)
            vec.lat.should == 5
            vec.lng.should == 4
          end

          it 'should Add one geo vector' do
            vec.add!("1,2")
            vec.lat.should == 5
            vec.lng.should == 4
          end
        end # add!
      end # point vector
      
      context 'Bearing vector (60, 2.km)' do
        let(:vec) { vec = [4, 2].vector }        
        let(:brng_vec) { BearingVector.new 60, 2.km }
        
        describe '#apply!' do
          it 'should raise error when applying bearing vector directly on a point vector' do
            lambda {vec.apply!(brng_vec)}.should raise_error
          end
        end
        
        describe '#+ (add)' do
          it 'should add the vector and create a new geo_vectors from result' do
            vectors = vec + brng_vec
            vectors.should be_a(GeoVectors)
          end
        end

        describe '#<< (push)' do
          it 'should add the vector and create a new point from result' do
            vectors = vec << brng_vec
            vectors.should be_a(GeoVectors)
          end
        end        
      end
      
    end
  end
end