require 'spec_helper'

describe GeoVector do
  describe 'Random module' do
    context 'Direction vector 4.km North' do
      describe '#random_vector' do      
        let (:vec) { vec = [4.km, :north].d_vector }
        
        it 'should return a random vector of up to 4.kms in any direction' do
          rvec = vec.random_vector
          rvec.distance.in_kms.should be_between(0, 4)
        end
      end
    end
  end
end