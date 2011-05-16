# h3. Addition
# 
# Vectors can be added to form a new Vector, using the simple formula vec = v1 + v2 = (v1.x + v2.y, v1.x + v2.y)
# 
# h3. Vector on Vector subtraction
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
  describe 'Vector on Vector Subtraction' do
    describe '#- operator' do
      let (:vec) { vec = [4, 3].vector }
      
      it 'should Subtract one geo vector' do
        v2 = vec - [1, 2].vector
        v2.lat.should == 3
        v2.lng.should == 1
      end
    end

    describe '#add! operator' do
      let (:vec) { vec = [4, 3].vector }
      
      it 'should Subtract one geo vector' do
        vec.sub!([1,2].vector)
        vec.lat.should == 3
        vec.lng.should == 1
      end

      describe 'converting args to vector' do
        it 'should Subtract after converting number args to geo vector' do
          vec.add!(1,2)
          vec.lat.should == 3
          vec.lng.should == 1
        end

        it 'should Subtract one geo vector' do
          vec.add!("1,2")
          vec.lat.should == 3
          vec.lng.should == 1
        end
      end
    end
  end
end