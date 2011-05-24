require 'spec_helper'
require 'geo_vectors/macros'

describe GeoVector do
  describe 'Random module' do
    context 'Point vector (4, 2)' do
      describe '#random_vector' do      
        let (:vec) { vec = [4, 2].vector }
        
        it 'should return a random vector to a point within bounding box' do
          rvec = vec.random_vector
          rvec.lat.should be_between(-4, 4)
          rvec.lng.should be_between(-2, 2)
        end
      end
    end
  end
end