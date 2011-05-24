require 'spec_helper'
require 'geo_vectors/macros'

describe GeoVectors do
  context 'an GeoVectors containing a PointVector v1, and a BearingVector v2' do
    let (:v1) { [1, 2].vector }
    let (:v2) { [30, 4.km].vector }
    let (:vecs) { GeoVectors.new v1, v2 }
    let (:point) { [3, 4].geo_point }

    describe '#vectors' do
      it 'should return the instances of GeoVector added' do
        vecs.vectors.first.should == v1
        vecs.vectors.last.should == v2
      end
    end

    describe '#to_s' do
      it 'should return vector seperated with ;' do
        vecs.to_s.should match /;/
      end
    end

    describe '#each' do
      it 'should return each vector' do
        vecs.each do |v| 
          v.should be_a GeoVector
        end
      end
    end

    describe '#map' do
      it 'should return each vector' do
        x = vecs.vectors.map do |v| 
          v.to_s
        end.join('#')        
        x.should match /#/
      end
    end


    describe '#directions' do
      it 'should return directions of all vectors' do
        dirs = vecs.directions
        dirs.should include(30)
        dirs.size.should == 2
      end
    end

    describe '#distances' do
      it 'should return distances of all vectors' do
        dists = vecs.distances
        dists.should include(4.km)
        dists.size.should == 2
      end
    end

    describe '#scale' do
      it 'should return distances of all vectors' do
        big_vecs = vecs.scale 2
        big_vecs.vectors.first.lat.should == 2
      end
    end

    describe '#scale' do
      it 'should return distances of all vectors' do
        vecs2 = vecs.dup
        vecs2.reduce 2
        vecs2.vectors.first.lat.should == 0.5
      end
    end


    describe 'Addition' do    
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
    
