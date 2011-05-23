require 'spec_helper'

describe GeoVectors do
  context 'an GeoVectors containing a PointVector v1, and a BearingVector v2' do
    let (:v1) { [1, 2].vector }
    let (:v2) { [30, 4.km].b_vector }
    let (:vecs) { GeoVectors.new v1, v2 }
    let (:point) { [3, 4].geo_point }

    describe '#vectors' do
      it 'should return the instances of GeoVector added' do
        vecs.vectors.first.should == v1
        vecs.vectors.last.should == v2
      end
    end
    
    describe '#add' do
      it 'should add vector to a point' do
        p2 = point.add vecs
        p2.lat.should > point.lat
      end
    end

    describe '#+' do
      it 'should add vector to a point' do
        old_lat = point.lat
        p2 = point + vecs
        p2.lat.should > point.lat
      end
    end
  
    describe 'Subtraction' do
      describe '#sub' do
        it 'should subtract vector from point' do
          p2 = point.sub(vecs)
          p2.lat.should < point.lat
        end
      end
  
      describe '#-' do
        it 'should subtract vector from point' do
          old_lat = point.lat
          p2 = point - vecs
          p2.lat.should < point.lat
        end
      end
    end
  end
end
    
