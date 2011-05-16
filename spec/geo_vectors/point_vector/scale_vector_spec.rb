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
  describe 'Scaling' do
    describe '#* operator' do
      let (:vec) { vec = [4, 2].geo_vector }
      
      it 'should scale the vector 2 times bigger (* 2)' do
        v2 = vec * 2
        v2.lat.should == 8
        v2.lng.should == 4
      end

      it 'should scale the vector to half size (* 0.5)' do
        v2 = vec * 0.5
        v2.lat.should == 2
        v2.lng.should == 1
      end
    end

    describe '#/ operator' do
      it 'should scale the vector 2 times bigger (/ 0.5)' do
        v2 = vec / 0.5
        v2.lat.should == 8
        v2.lng.should == 4
      end

      it 'should scale the vector to half size bigger (/ 2)' do
        v2 = vec / 2
        v2.lat.should == 2
        v2.lng.should == 1
      end
    end
    
    describe '# scale! operator' do
      it 'should scale the vector 2 times bigger (* 2)' do
        vec.scale!(2)
        vec.lat.should == 8
        vec.lng.should == 4      
      end
    end
  end
end